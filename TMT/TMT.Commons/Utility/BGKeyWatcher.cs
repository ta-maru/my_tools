using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;
using System.Threading;
using System.Threading.Tasks;

// <summary>
/// キー押下をバックグラウンドで検知する
/// </summary>
public class BGKeyWatcher
{
    private object _lock = new object();

    private event EventHandler<EventArgs> _callBackMethod;

    private List<IntPtr> _keyCodeList;

    private int _interval;

    private Task _task;

    private bool stopFlag = false;


    [DllImport("user32.dll")]
    private static extern IntPtr GetAsyncKeyState(IntPtr nVirtKey);

    private const Int64 mask64 = (Int64)0x8000;

    /// <summary>
    /// 指定されたキーが押下された場合にイベントを発生させる
    /// </summary>
    /// <param name="keyCode">監視するキーコード</param>
    /// <param name="interval">監視間隔（ミリ秒）</param>
    public BGKeyWatcher(EventHandler<EventArgs> callBackMethod, int[] keyCode, int interval = 500)
    {
        _keyCodeList = new List<IntPtr>(keyCode.Length);

        foreach (int x in keyCode)
        {
            _keyCodeList.Add(new IntPtr(x));
        }

        _interval = interval;
        _callBackMethod = callBackMethod;
    }

    /// <summary>
    /// 指定されたキー状態を監視する
    /// </summary>
    public void Watch()
    {
        lock (_lock)
        {
            // 多重起動防止
            if (_task != null)
                if (_task.Status == TaskStatus.Running)
                    return;

            // 停止フラグ
            stopFlag = true;
        }

        // 監視開始
        _task = new Task(WatchKeys);
        _task.Start();
    }

    /// <summary>
    /// 観察を中断する
    /// </summary>
    public void Abort()
    {
        lock (_lock)
        {
            stopFlag = false;
        }
    }

    /// <summary>
    /// 指定されたキーを監視する
    /// </summary>
    private void WatchKeys()
    {
        while (stopFlag)
        {
            if (_keyCodeList.Exists(x => WatchKey(x)))
            {
                // 見つかったらコールバック
                _callBackMethod(this, new EventArgs());
            }

            // 見つからない場合は待機
            Thread.Sleep(_interval);
        }
    }

    /// <summary>
    /// 指定されたキーが押下されたか判定
    /// </summary>
    private bool WatchKey(IntPtr code)
    {
        var ret1 = GetAsyncKeyState(code).ToInt64();

        var ret2 = ret1 & mask64;

        return (ret2 != 0);
    }
}

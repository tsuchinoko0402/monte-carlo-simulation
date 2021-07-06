using Random
using PyPlot

# 粒子の数
const PARTICLE = 2000
# 領域の大きさ
const MAX = 50.0
# 終了時刻
const T_END = 500
# 粒子の x 座標と y 座標：初期値はすべて原点
x = zeros(Float64, PARTICLE)
y = zeros(Float64, PARTICLE)
# 原点からの平均距離
d = zeros(Float64, T_END)

# メイン関数
function main()
    t = 0
    while t < T_END
        # 粒子のシミュレーション結果のギラフィック用意
        fig = PyPlot.figure(figsize=(12.0, 12.0))
        ax = fig.add_subplot()
        ax.set_xlim(-MAX, MAX)
        ax.set_ylim(-MAX, MAX)

        # 初期化
        d1 = 0.0
        
        # 個々の粒子の衝撃
        for i = 1:PARTICLE
            θ = 2.0π * rand()
            x[i] += cos(θ)
            y[i] += sin(θ)
            d1 += sqrt(x[i]^2 + y[i]^2) / PARTICLE
        end

        d[t+1] = d1

        # 粒子を描画
        ax.scatter(x, y, marker="o", s=1, color="blue")
        plt.savefig("./result/figure.$(t).png")
        plt.close()

        # 時刻を1単位時間進める
        t += 1
    end

    # 原点からの距離のグラフを描画
    fig = PyPlot.figure(figsize=(6.0, 6.0))
    ax = fig.add_subplot()
    ax.plot(1:T_END, d)
    plt.savefig("./result/distance.png")

end

main()
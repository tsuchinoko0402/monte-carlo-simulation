using Random
using PyPlot
using Distributions

# 粒子の数
const PARTICLE = 1000
# 領域の大きさ
const MAX = 50.0
# 終了時刻
const T_END = 10000


# メイン関数
function main()
    t = 0
    x = zeros(Float64, PARTICLE)
    y = zeros(Float64, PARTICLE)

    # 粒子の x 座標と y 座標：初期値は一様分布
    for i = 1:PARTICLE
        x[i] = MAX * (2.0rand() - 1.0)
        y[i] = MAX * (2.0rand() - 1.0)
    end

    while t < T_END
        # 粒子のシミュレーション結果のグラフィック用意
        fig = PyPlot.figure(figsize=(12.0, 12.0))
        ax = fig.add_subplot()
        ax.set_xlim(-MAX, MAX)
        ax.set_ylim(-MAX, MAX)

        # 粒子を描画
        ax.scatter(x, y, marker="o", s=1, color="blue")
        plt.savefig("./result/figure.$(t).png")
        plt.close()
        
        # 個々の粒子の衝撃
        for i = 1:PARTICLE
            θ = 2.0π * rand()
            l = sqrt(2.0) * MAX - sqrt(x[i]^2 + y[i]^2)
            x[i] += l * cos(θ)
            y[i] += l * sin(θ)

            # 境界条件: 反射
            if x[i] >= MAX
                x[i] = 2.0MAX - x[i]
            end
            if x[i] <= -MAX
                x[i] = -2.0MAX - x[i]
            end
            if y[i] >= MAX
                y[i] = 2.0MAX - y[i]
            end
            if y[i] <= -MAX
                y[i] = -2.0MAX - y[i]
            end
        end

        # 時刻を1単位時間進める
        t += 1
    end
end

main()
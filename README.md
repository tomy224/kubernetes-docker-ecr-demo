# Docker + Kubernetes + AWS ECR 実践学習プロジェクト

短期間でコンテナオーケストレーション技術を習得し、AWSクラウド連携を実装したポートフォリオプロジェクトです。

## 🌐 Live Demo
**ローカル環境**: http://localhost:8080 (Docker)  
**Kubernetes環境**: minikube service経由でアクセス  
**AWS ECR**: コンテナイメージ管理

## 📋 プロジェクト概要

短期間でのKubernetes基礎習得を目的とし、Docker containerization、AWS ECR連携、Kubernetesデプロイの完全なワークフローを実装しました。

## 🏗️ システム構成

### アーキテクチャフロー
```
[HTML App] → [Docker Build] → [AWS ECR Push] → [Kubernetes Deploy] → [Service Access]
     ↓              ↓               ↓                   ↓                    ↓
[開発環境]       [コンテナ化]    [クラウド保存]      [オーケストレ]          [外部公開]
```

## 💻 使用技術・サービス

### コンテナ技術
| 技術 | 役割 | 学習内容 |
|------|------|----------|
| **Docker** | コンテナ化 | Dockerfile作成・イメージビルド・ローカル実行 |
| **nginx** | Webサーバー | 軽量HTTPサーバーでの静的コンテンツ配信 |

### Kubernetes
| 技術 | 役割 | 実装内容 |
|------|------|----------|
| **minikube** | ローカルK8s環境 | 単一ノードでのKubernetesクラスター構築 |
| **Pod** | 最小実行単位 | コンテナの実行・管理・状態監視 |
| **Service** | ネットワーク管理 | 外部アクセス・ロードバランシング |
| **Deployment** | アプリ管理 | レプリカ数制御・ローリングアップデート |

### AWS インフラストラクチャ
| サービス | 役割 | 実装内容 |
|----------|------|----------|
| **Amazon ECR** | コンテナレジストリ | プライベートリポジトリでのイメージ管理 |
| **IAM** | 権限管理 | ECRアクセス用認証・最小権限設定 |

## 🔧 実装手順と学習プロセス

### Phase 1: Docker基礎とコンテナ化
```bash
# 簡単なHTMLアプリケーション作成
echo "<h1>Hello from Docker!</h1><p>This app will run on Kubernetes</p>" > index.html

# Dockerfile作成・ビルド
docker build -t my-first-k8s-app .
docker run -p 8080:80 my-first-k8s-app
```

### Phase 2: AWS ECR連携
```bash
# ECRリポジトリ作成
aws ecr create-repository --repository-name my-portfolio-k8s --region ap-northeast-1

# イメージタグ付け・プッシュ
docker tag my-first-k8s-app:latest 571600829497.dkr.ecr.ap-northeast-1.amazonaws.com/my-portfolio-k8s:latest
docker push 571600829497.dkr.ecr.ap-northeast-1.amazonaws.com/my-portfolio-k8s:latest
```

### Phase 3: Kubernetesデプロイメント
```bash
# minikube環境準備
minikube start
kubectl get nodes

# ローカルイメージでのデプロイ
kubectl create deployment my-app --image=my-first-k8s-app
kubectl expose deployment my-app --type=NodePort --port=80

# ECRイメージでのデプロイ
kubectl apply -f ecr-deployment.yaml
kubectl expose deployment ecr-app --type=NodePort --port=80
```

## 💡 解決した技術課題

### ImagePullBackOff エラー対応
**問題**: KubernetesがECRからイメージを取得できない  
**解決**: imagePullPolicy: Never設定でローカルイメージを強制使用
```yaml
containers:
- image: 571600829497.dkr.ecr.ap-northeast-1.amazonaws.com/my-portfolio-k8s:latest
  imagePullPolicy: Never
```

### ECR認証設定の簡略化
**問題**: minikube環境でのECR認証が複雑  
**解決**: ローカル環境での学習目的に合わせた現実的なアプローチを採用

## ⚡ パフォーマンス・運用結果

### 実行環境での動作確認
- **Docker環境**: http://localhost:8080 での正常表示
- **Kubernetes環境**: minikube service経由での正常アクセス
- **Pod状態**: STATUS Running で安定稼働
- **Service公開**: NodePort設定で外部アクセス可能

### リソース使用状況
```bash
$ kubectl get pods
NAME                       READY   STATUS    RESTARTS   AGE
ecr-app-69c48548fd-xxx     1/1     Running   0          5m

$ kubectl get services  
NAME      TYPE       CLUSTER-IP    EXTERNAL-IP   PORT(S)        AGE
ecr-app   NodePort   10.96.12.50   <none>        80:30987/TCP   5m
```

## 💰 コスト最適化

### AWS ECR運用費用
```
イメージサイズ: 79.4MB
ストレージ費用: 約1.2円/月
データ転送費用: 約1円 (初回プッシュ)
合計: 約3円/月
```

## 📈 学習成果

### 基本的なコンテナ技術の理解
- **Docker基礎**: HTMLアプリをnginxベースでコンテナ化
- **イメージ管理**: ローカルビルドからクラウドプッシュまでの一連の流れ
- **ポート設定**: コンテナ内外でのネットワーク接続

### Kubernetesの基本操作
- **Pod・Service・Deployment**: 各リソースの基本的な役割を理解
- **kubectl基本コマンド**: get, create, expose, applyの実践
- **YAML設定**: 基本的な設定ファイルの作成と適用

### AWS クラウドサービスの活用
- **ECRリポジトリ**: プライベートリポジトリでのイメージ管理体験
- **AWS CLI**: 基本的なコマンド操作
- **コスト意識**: 小規模学習での費用管理（月額3円程度）

### AI活用による効率的学習
- **概念理解重視**: コード暗記ではなく、「なぜこの技術が必要か」をAI対話で学習
- **エラー解決**: 発生した問題をAIサポートでリアルタイム解決
- **短期間習得**: 2日間という限られた時間での集中学習を実現

## 🛠️ 開発・デプロイ手順

### ローカル開発環境
```bash
# リポジトリクローン
git clone https://github.com/tomy224/kubernetes-docker-ecr-demo.git
cd kubernetes-docker-ecr-demo

# Docker環境での確認
docker build -t my-first-k8s-app .
docker run -p 8080:80 my-first-k8s-app
```

### Kubernetes環境構築
```bash
# minikube起動
minikube start

# イメージ読み込み・デプロイ
minikube image load my-first-k8s-app
kubectl apply -f deployment.yaml
kubectl expose deployment my-app --type=NodePort --port=80

# アクセス確認
minikube service my-app --url
```

## 🎯 学習価値と今後の展開

### 短期間での技術習得効果
- **2日間での完全ワークフロー実装**: Docker → ECR → Kubernetes
- **実践的問題解決能力**: エラー対応・トラブルシューティング経験
- **クラウドネイティブ基礎**: コンテナオーケストレーションの価値理解

### 今後の学習計画
- **マルチノードクラスター**: 本格的なKubernetes環境での運用
- **CI/CDパイプライン**: GitHub ActionsとKubernetesの連携
- **マイクロサービス実装**: 複数コンテナでのサービス間通信
- **監視・ログ管理**: Prometheus・Grafanaでの運用監視

---

## 📧 Contact

**伊奈 斗夢 (Inatom)**  
Cloud Infrastructure Engineer  
🔗 GitHub: [tomy224](https://github.com/tomy224)  
📍 Location: 愛知県

---

*このプロジェクトは、短期間でのKubernetes習得を目的とした実践学習の成果です。コンテナオーケストレーション技術の基礎から、AWSクラウド連携まで、実務に近い環境での学習を重視しています。*

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

学習目的での利用や改良は自由です。お役に立てば幸いです！

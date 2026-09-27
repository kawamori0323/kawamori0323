

> ## 個人開発・ポートフォリオ <span class="card"></span>
> 
> ### 🚀 Memo-z（マルチリポジトリ型 どこでも使えるクラウドメモアプリ）
> Webブラウザから利用できるクラウドメモアプリ。ログイン後にリッチテキスト形式でメモを作成・管理でき、スマートフォン、タブレット、PCを問わず利用可能。
> 既存のメモアプリでは実現したい操作やカスタマイズ性に不足を感じたため、技術習得を兼ねて開発した。
> 今後の拡張として、特定のキーワードの色をリアルタイムに変更する機能も検討している。
> 
> | 項目 | 内容 |
> | :--- | :--- |
> | **システム構成** | マルチリポジトリ構成（Base環境基盤 / Goバックエンド / Reactフロントエンド） |
> | **バックエンド** | **Go**, **Gin**, **Clean Architecture**（Domain / Usecase / Handler / Adapter / Middleware） |
> | **フロントエンド** | **TypeScript**, **React**, **Next.js**（トークン認証管理）, **Tiptap**（リッチテキストエディタ） |
> | **認証・認可** | **Amazon Cognito**（User Pools / JWTトークン検証・認可ミドルウェア auth.go） |
> | **クラウド・DB** | **AWS**（Lambda Function URL, DynamoDB, S3 + CloudFront） |
> | **IaC・開発基盤** | **Terraform** (インフラ完全コード化), **mise**, **GitHub Codespaces**, Dev Containers |
> 
> #### 設計・実装のこだわりとアピールポイント
> - **Go言語によるクリーンアーキテクチャ設計**
>  ・`domain`, `usecase`, `handler`, `infrastructure/adapter/dynamodb` に厳密にレイヤーを分離し、テスタビリティと疎結合性を追求。
> - **AWSサーバーレス × Terraform による完全IaC化**
>  ・Go（Lambda Function URL）+ DynamoDBを採用し、スケーラビリティと運用コストを考慮した構成。LambdaやS3 / CloudFrontを含む全リソースをTerraformで自動構築・管理。
>  ・単一のスクリプト実行で、Terraformによるインフラ構築からビルド・リリースまで完了するCI/CD環境を整備。
> - **CognitoによるセキュアなJWT認証・認可ミドルウェア**
>  ・Next.js側で取得した認証JWTトークンを、Goバックエンドの認証ミドルウェアで検証・認可制御。
> - **Dev Containers + mise による統一開発環境**
>  ・CodespacesとDev Containersにmiseを組み合わせ、Codespaces環境作成と同時に開発環境の構築・初期化が完了する再現性の高いBase環境基盤を構築。
>  ・認証関連の秘密情報はCodespaces Secretsで管理し、初期化時に環境変数に注入するなど、セキュアかつ作業コストを抑えた環境構成の実現。

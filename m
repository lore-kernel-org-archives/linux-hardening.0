Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3635ADDB0;
	Mon, 23 Oct 2023 07:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V4YkQ3Xa"
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1A3D7D;
	Mon, 23 Oct 2023 00:43:43 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9bf0ac97fdeso413581066b.2;
        Mon, 23 Oct 2023 00:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698047022; x=1698651822; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iaSNLjd6qp2TTeM4lQ0nSQjwYYZEfvjgfhn3UAjO2Dc=;
        b=V4YkQ3Xalf5xzAQBlr1K5hkCfVapRhG89z3sYn7CATweYESyx2vjGziY8/JyDgViS7
         DhO0DmZlOWpPGR0Mo3rnjCHw3b2wLakgUNDxJiW7nj7jFDHuHZqYitliweaiK1jwpJMW
         YSTlqeP6CMn47oVDLJW8jivq0Y/AtHt9dpDKesG8kGvDBozJcgia1EGyVs26fJmWlW/A
         t5mQ3XQgCa9hf9v0RwjBYcUxXK2DHsggtmqQ0dfaHs6f4bluzVR/S/4Ma6YqhgaMq0Nr
         bJwwLI/CewM90NOvwEHV/yM8QTVR2kJ+4/slokXklRzk8daooDvFZVbWQ6fndwslD0Bk
         MNlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698047022; x=1698651822;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iaSNLjd6qp2TTeM4lQ0nSQjwYYZEfvjgfhn3UAjO2Dc=;
        b=t0cKsyOPaCvfphODrAG1fmzoF6hbStKw/ApBK1QWwrMumlZL4MjJMxbVXBFJ6Cc+sg
         kwpSsl941lMTNbNhJVABXnArlgxCI45C0GK6eMf2a0ZzXHNbBw39s4kD7KymntMvzaoy
         oJei8/tjGxWeQXrkdmrH53r9tDdMQPdk722zlzZgk2HMNbCq0V+43lzAY+pwWxPneUPC
         XJ8F46GNm5ugupGA9Iu1Z7dHZhtTR8cT+A2qaCYxj4Fn+Nl9HPnIDW0GiQlb0GlmMrVZ
         slzIbt4WcHTuJafI1lEx6O7yS28bhssXIRaYHf99K5xiLPTSGVzRk/D+oketukT1Cctq
         qNDQ==
X-Gm-Message-State: AOJu0YwGZdxGN2B9cdFGh+rEZ4M/hY97Rm88Qz5vk66+QUG6KgyEeGoj
	9NkSCt08WQLvxJSwv5L/8Yc=
X-Google-Smtp-Source: AGHT+IEKGMPqeJCCmve2rHM/shqVOl5e3b275jp0DUGbU0G1JlkIsmVac4sAMRnQqYGiON5fTcEWfA==
X-Received: by 2002:a17:906:6a19:b0:9c7:5a01:ffe7 with SMTP id qw25-20020a1709066a1900b009c75a01ffe7mr6709512ejc.12.1698047021694;
        Mon, 23 Oct 2023 00:43:41 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:3344:1b7d:7200::eba])
        by smtp.gmail.com with ESMTPSA id la5-20020a170906ad8500b009adce1c97ccsm6123395ejb.53.2023.10.23.00.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 00:43:41 -0700 (PDT)
From: Luka Panio <lukapanio@gmail.com>
To: Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Tony Luck <tony.luck@intel.com>,
	"Guilherme G . Piccoli" <gpiccoli@igalia.com>,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: Luka Panio <lukapanio@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v7 1/2] dt-bindings: arm: qcom: Add Xiaomi Pad 6 (xiaomi-pipa)
Date: Mon, 23 Oct 2023 09:43:35 +0200
Message-ID: <20231023074336.14535-1-lukapanio@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a compatible for Xiaomi Pad 6.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Luka Panio <lukapanio@gmail.com>

---
v2:
Update commit message

v3:
Update commit message

v4:
Update commit message

v5:
Update commit message

v6:
Update commit message
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index adbfaea32343..1bfae1b237d2 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -965,6 +965,7 @@ properties:
               - sony,pdx203-generic
               - sony,pdx206-generic
               - xiaomi,elish
+              - xiaomi,pipa
           - const: qcom,sm8250
 
       - items:
-- 
2.42.0


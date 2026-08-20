Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E263FF8B9
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 09:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218980; cv=none; b=SzCB2LVGDBDne7xiIqE1wM8KBsJKp89jTikzyJrGYlb5hvRKNLPn4JqzjvbP7b64wnEmPmfpgLHu/t8tcpBJO20D77AbgM1x/HyMMcMQE523PH6k6Kg2FnLMqSnQhmch377aDJx6e4vmz6ydo62QOCjS1TZtU1bIpFhcamILbaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218980; c=relaxed/simple;
	bh=aRikrKedr8rRD84dJqfsSjKHfSLi0ROhZlN789CUbJc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iMrRZyXKlanNwTGbXke8mJU5xL/4Qr2pr7k6Zan9jJt2CUQj2RMcFsdKEAUEP1/J7tByzGkhgMlDDnBAN+9IUH8yKziE1BAtGeUn26NTENRczcGYdB9vwjW/0Fxh6/6qtHQacf+K5WWimrWoIeSUrK9Nla6CGxlxVLKP5LFuFZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JYQrHhqw; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JYQrHhqw"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-47f904e80eeso1872667f8f.1
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 02:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787218967; x=1787823767; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=K/a/K4l60N8ZYR9C9kOGDnGGvsCsbHCt+W0MVudFPQc=;
        b=JYQrHhqwDunqVDwPcJHQUvP9aXnxfrHW9Xwakk+BYY1l3JiTN3MewFxDzsoGljwHKp
         scScVkTBq5ZndXqf0MPLPiISlydMfqdIpCicEDMH1o6xfXCQKeha5Z3UbT0/BV7xWQsU
         WXP7CaktAaJ5K5Z6vgBhFrRDGHiREoCGnh/RvcQ2Oi56gNpgJdrjQMKkdxbZul1vNm5+
         rT5DCVHXsAfhugDOzBbhRDakI3cr4UQgIzfNNloJLwI6qlbA2NI35C1JAC0AywadFr2H
         lZ/Pzd2qPGjgcUsO9S76xU6gTRupEyVWoCN09LMWk6IgKhN2x/rpiXJzDEMKrSd7kSh+
         mNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218967; x=1787823767;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K/a/K4l60N8ZYR9C9kOGDnGGvsCsbHCt+W0MVudFPQc=;
        b=sYA6VPIBpCdWu0GZvGKjP4ZY1obZJT4sZ4/o6ZKAAN9PM+fNwLFmAOQ56fdLYN1Rqi
         GEyJ5nSl/K9xNz2XMm+itSBkIdIZ4o5buy+mvDATWQ8Sfl3eRAIQyjxYvZM48SL+vFa6
         4Lplpew4ma1KsZqNNobkOUPPNqC+PdjPj/FG4P+HMoEW1n2vFmQSh0qouPYH7vr39zT2
         GFTHl1kA+MT8Abnm1Xqwp3pBl95D3lBU05xECkzU9FtUFfnGuc5oawcwFyEPmty/RuVb
         96bfEkLe4LMIccxoqDQ7UDxHHqLg/SCMufjDB+E2vgEBMDBE7GdlzgZ2gVgMccbBO+d9
         9Clw==
X-Forwarded-Encrypted: i=1; AHgh+Rptg2uvSXjF9bJgiogHDX0Ar/RolkPhr2SXukSVL4b3Ql3ber3AYJwb/j2slwjhwbEJteoncbpdJN5y8c+ATC8=@vger.kernel.org
X-Gm-Message-State: AFuF++luYKt7SSuFto3skz7QfNFeZ3D3yavqxZHYV/ywg1C8cfLPpD2z
	Qm/8qXkNAbv5Yx+TE8DZzLZlNd2zAPFv4myVaJXW9klMtHGQGbqSTruR
X-Gm-Gg: AR+sD12nLf2By4dowcRr8u25NFwUrk5+9JmN3wqPdhWMXXf8odSsuL884hATQprX8Mv
	tBQ+je7Ve7Og+VfYGuJYf3stQk+RtxTjo1DMg5l6ng81+KLh3lMpQk4FSTasQkPVK5edcv2RB7F
	HwVhnBN3/EmjEBYrvb0pqhsHfBtDksQs4zks5ZV3ZJcV58jiDzWnG7XZ6scvu6r90sAoIMd9Tx/
	jrGjEL1knST62o1PmyNoHZ2en7J79XlUlwq/yR0kcwKs9bb2/hoQhrw6vtayPMh6bPapI/Ku9vr
	H53k3PCe8kYpRu4vpi+eRduLQIFpLxb3Rmp6iiu9v+FvTepEaW0COoiTSTdffTRZ5DVPoQDmg9O
	L2MA09DFN0Y1pvP7xqQij4Ca9I0XtupUkDZPeeEP40QgmB/jTrF5krmNgPXLYpfj7OMiOh6Sf4s
	ufzUr7D2TWfIqqOvYBdueeqVDnpIaGJlBqav+IxHXcRiuVP9KhEhH/uwen9UVdQJ2f3Ut3XCmIC
	1HnYWHAHsEWZjhkuvenJ9JB
X-Received: by 2002:a05:6000:4b08:b0:482:9a18:d753 with SMTP id ffacd0b85a97d-482b1e872f0mr21368794f8f.5.1787218966783;
        Thu, 20 Aug 2026 02:42:46 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b144173csm11788090f8f.6.2026.08.20.02.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:42:46 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Thu, 20 Aug 2026 11:42:29 +0200
Subject: [PATCH v2 6/7] dt-bindings: arm: qcom: Document Xiaomi Redmi 9T
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-next-patches-v2-6-7130d68183d9@gmail.com>
References: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
In-Reply-To: <20260820-next-patches-v2-0-7130d68183d9@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Adam Skladowski <a39.skl@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

Add compatible for Xiaomi Redmi 9T NFC codename lemon which is one
of variants of Xiaomi Citrus lineup based on Snapdragon 662 SoC.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 68542f76df30..5363efadd4ee 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1035,6 +1035,7 @@ properties:
       - items:
           - enum:
               - fxtec,pro1x
+              - xiaomi,lemon
           - const: qcom,sm6115
 
       - items:

-- 
2.55.0


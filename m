Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9B828DF21
	for <linux-hardening@vger.kernel.org>; Thu, 19 Jun 2025 14:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750344936; cv=none; b=rwh9LJMYoLgE33pjDz/p0qtXPlHOCUH8+fvU4dRmif+wN4EGaapZK8EPKnZeqdEvlQGUveb1HW0/XRBcLfWJnGnvrh1b0cy95m+wQHCU2bCZd7USxeTOLly0ZnrP1ISo/ncT1aesPBoIRvQ+Eu1tD925K5dBbYLIhSxBOpV1UEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750344936; c=relaxed/simple;
	bh=iDLIU8cKqvcbXUMIYZ0LyAHF4U27oo4VJDAhYAedWfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=olYZvgDYLViQq5HZPHDXz0+TtjnAMjm9vju4oDV8Wn4fI1/K2L9BrsIgXi2u9OhkU76iMW8OA25E5zZG0z+XmL7kaEhGK66lUi4w1Aix4sU/DfIAcpQx8ODUJh3Duu8lfKHyntc0PJSeeh3YKUkafBaek7c7psDtw4hpoMlCHdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XjycNjfh; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XjycNjfh"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-451d6ade159so6966805e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 19 Jun 2025 07:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1750344931; x=1750949731; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e9GucHfZPCayxh1y8Bqgadbm6OXspkCQUE4SSbOEVnA=;
        b=XjycNjfhOvt2kNBpm+RHazbZfv9Q0LvHUmDtRIhyaXZo8JODRgLZYD4WjBzsVuktxH
         TS/+a0im5wzY7CpSzvFxl9jkg2kSJ48xrgWVRAFIyFSfqA8dBthJvQcb4tk6ofaaz4EO
         fdyrPALL2DbpZwmDiFHYUHlCas3WS9AA7ydMwWSLxspaTge4ikOdZYDnWzl3traVaidE
         1ZbXx6y5AnS/nqES6y+seHadVm09zhhjBeld1mGIGD83vXQAisFrDlXhmEwegFjZn9lr
         89b0dng7Ll88OzkYn5YnZ01TX0OMc/HeQ+MGuKUSS123cmLrcu95S98qbF48UDcrRP8w
         m8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750344931; x=1750949731;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e9GucHfZPCayxh1y8Bqgadbm6OXspkCQUE4SSbOEVnA=;
        b=TdGOFPvJOU/uRCDp8DFObDS3+Xz27Xsgunfodj2vf85+lCBMGvxDBCnkaBC1qKc1Ba
         MS95A0aj0KSypUhJHc9oH8ABF40929V47iim/vIMoN/KlBqZFPciGYyZox9PBqPWTyzL
         kh70uXY+KxBt3wO7O1PsdhjX8mha/l0vALgapvg9kVP+84ntmONg8FQFO98tMj1zmGrj
         ngJHoYFd4yJbVWZH/TIG61rhpK2sMOSL45LZ35Xk0HS8X648XOYsfOh78OiuRUVSXMae
         Eg/HbfDx0GFHhKVUvxN8SpNctqjMn/xxPvGGILT1E7BybxgftV5WlGOnrorI9AKgXVeI
         m/ig==
X-Forwarded-Encrypted: i=1; AJvYcCXJsM7L37XSXvxCWWWUIrYCXGlpRitXmV2gu6yCjsPQvfOZrS5mgzBfWCNSBftJc+7+BNMp1yCXG3ZxJpkpnE0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmmPnLkoF1ShLUCCKxo50JhBAtvO1LN1ZqYeE3ayxar+43/D2V
	Vyszg8mmDJqiz4RgK3mPBe5s5uBS/ZD6l0wJCq1zJszaEBIeRfVeqcuKklwpy27zuWA=
X-Gm-Gg: ASbGncvNs0d7jbFp1PeqsjaDCNMJkLK6s51IEtsih1wiLILuYf08XNWky+NSRC7XbPD
	/Ok07e8/K4CH9/4mbaR40TV5pTwvwhzockLl7a6ifNfjydkt96s0AyemoINie1lx8BNVAZq3CCC
	HdjkZMpNBvb4P1miL01n2Ob2S+krJmEKR5nEXt4e68Aje27ZIxWlIvG+CUnuS+gtoRrYKdN+/eK
	GLV1/9AUb35d6b9CbUK3rSUhNwZ5samKDKMJiZQl1ErQIk/Mca8Fbydlf2rFtjC48hXL2H/E0dH
	+i1bjTTgHV0QEf2krz+KKtLZHTW9DPZd3rFvYHbDJ2evaK2wi/b4ndEFex5bUW7cXBWw/ei5+st
	onPzquy4u8GMnOf08W1f7LA==
X-Google-Smtp-Source: AGHT+IGGobIpKkCLpRzDl1QxoCvpwI+jTHKHBg4d9lnILMNs8XoDrDP97vfxlViyNKxyIg5xdhuMjw==
X-Received: by 2002:a05:600c:5025:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-4533cb5ddabmr223699075e9.31.1750344930711;
        Thu, 19 Jun 2025 07:55:30 -0700 (PDT)
Received: from toyger.tail248178.ts.net ([2a0e:c5c1:0:100:b058:b8f5:b561:423c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ebced8asm31343715e9.40.2025.06.19.07.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jun 2025 07:55:30 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
Date: Thu, 19 Jun 2025 16:55:18 +0200
Subject: [PATCH 10/11] MAINTAINERS: add myself as smbx charger driver
 maintainer
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-smb2-smb5-support-v1-10-ac5dec51b6e1@linaro.org>
References: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
In-Reply-To: <20250619-smb2-smb5-support-v1-0-ac5dec51b6e1@linaro.org>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 linux-hardening@vger.kernel.org, Casey Connolly <casey.connolly@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=971;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=iDLIU8cKqvcbXUMIYZ0LyAHF4U27oo4VJDAhYAedWfo=;
 b=owEBbQKS/ZANAwAKAQWDMSsZX2S2AcsmYgBoVCTSU5Fs57qbeZWVqSoR+0UKygRpv6l1Ryj9+
 AffIy9CL9KJAjMEAAEKAB0WIQS2UaFGPGq+0GkMVc0FgzErGV9ktgUCaFQk0gAKCRAFgzErGV9k
 tu2VD/0bwY7vbtIlaRWJOFEsK2l1vGsoZuolMH38cKaAlU+IG2W1Fyq7WlUOc2DUn81OGrnksUG
 yr9FjFGovg0DW/ycFt2vSbP6LA7yLbYPanceKT5Plpoj04RZjUbpHkwBACBHVFFo9N9Hy6S+gpd
 g4Srrq5bUjcAKOiSoJO/XIDkoxNV3rdRsJHgBwcoAlMfjoLbGM/soOrqLKhoz/JQqGJUxLsxVL+
 5xU/dSpdXppIkgbzQ6Bjifldq+0v1l7ScdXUTo2Buew2c8zf5nVBkeniJnZ3F6zWXwnaMfBfNBb
 Bq0SYmvymuQeXCYEKqfIUzC+Y0XbTK04cjjeTDwswET04SL2LwBOsmOX0EBIYhum1QjaF6QiGVm
 QJYn35ZyzKMTDoZCO/V6huqhrp8h6t9UGwVfk+YJlJp1NQgH+4sAXTaFqRQzuaUAMsN+wv3GJqV
 kpwMVH4S21qj41ZgWQrHd+QM7Xk4I61d5mXkZt6afscFVFax4lCIRnjUWcn9NbVlACvCJ6fVsLT
 Iwgamw41FbjE6dCtXHRuYKEcssWNZ0trX+cZZhkQyFi9pdyXHMmXQwMKIXDW6IjCsS3ry8F3Qvr
 61LmxgvrbQC5+ViIxKJcQzemtaZisZlI0/HzjEaCGTpCYdTVBmDtMGhV6RSh18t5bE0Dc3D2Ttx
 c1Wm6jRS/gyDmfg==
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47

Missed when this originally went upstream, add myself to the MAINTAINERS
file for this driver.

Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2b570ed5f2f28341a3bcb7b699cbb250ffa2a88..a32e53d89c29cacf6e456258c4c7c0206cf8abf2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20565,8 +20565,15 @@ L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/mtd/qcom,nandc.yaml
 F:	drivers/mtd/nand/raw/qcom_nandc.c
 
+QUALCOMM SMB2 CHARGER DRIVER
+M:	Casey Connolly <casey.connolly@linaro.org>
+L:	linux-arm-msm@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/power/supply/qcom,pmi8998-charger.yaml
+F:	drivers/power/supply/qcom_smbx_charger.c
+
 QUALCOMM QSEECOM DRIVER
 M:	Maximilian Luz <luzmaximilian@gmail.com>
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained

-- 
2.49.0


Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1755042D778
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380974; cv=none; b=svB4eqCs0m+gLLod+tfMu1zGMI3GXnfkfzhNjWyr5WyJczbibEnWjYdgg9pNurO1ehkJkkuzhJNYKMSqu+PFGAO1SRscZ/rOoLr292hQ/e7wLbl6SOwzFEgoDuAoYYdgVq+ExJDzFaQclV3xkoaAL9r3qP4TcV690lQEhQAA1ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380974; c=relaxed/simple;
	bh=1SYlMirSvskMxjieAuqurmagvIfN1UzuJsj9AZoY2tA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lnifktF6UQq2qkRCWwSZiDTpFliINmEWLrtKGqGj65Ie/hRwfFzgX8pb2018OMg5utfObHcbRbmLTIa7fKrH/7KxvEasiJNnqcYM/GA99bx5q1hhDiyeD087BsxT4gvVvAYmFhuINWAsEn3D1sXGP/3+7FVYFC0N6goWKGe8cI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AAhrPJon; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AAhrPJon"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4953e04ef16so18792315e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 09:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380971; x=1786985771; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2oiq43xN/9r6N67wuOQuSc1w14BdYaHpgY6CuLp6gzE=;
        b=AAhrPJonA7OVSdn0eK3UyMAR0ckYyc+zpEnXuBx2l8/JqHgUrFbmH9cMqCok7/kd8h
         KFNj7n9Vi6cMoga2HmJDx7H3tOt+8VEn5pVEv8lLqzl+E0Cn1ovvAeuKCGrPrPTgcDgk
         VAeMjkhaHLzZ1b6a+sIK2486nkc/z4QlKcrx4XJI6zx4jn+BxkY9uyh5b4Y+Qsj1aYCs
         HVizKuViAEt80c4LFAPRktuFRi/xvI/5xZDxzISChzErFpvvezlMkxyy16SXOz7N3PZb
         B/ZW2R3/ISq2+3HuBIY/VKBnUIZYUFpSVyBLcu08UjQiFOA3Oie82FIXl0/MhOajG0ON
         Cg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380971; x=1786985771;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2oiq43xN/9r6N67wuOQuSc1w14BdYaHpgY6CuLp6gzE=;
        b=MBA+LO4WGj4znd1qe8FZ7c+ABbvOSBi4W/N3looiwjvkyznShN2IcbbA9uGso7MAnc
         GUUb6gMA7tBJSFlb8/WC7OHY1AwkDFpbwiC5axw+2AHMJx2VokhhNjlOfjnzr/7kqCjB
         5sSmtgd9OzM45/cJ3aV5vSUHrgRTbqWN2/FfcskYZ2aFjugEf2IlmipkspdgU776LB6l
         vUjEG+4sDMzA8ukn6Vqwsjq6ln6T0syyAWStCjgO/ZZ2R8xbnWlaqbacA3Nhn7dIDsHF
         W05siiHVkwUpoSX8YBVgCbMAF2HCQKt53qx1sEXAAz+qv4jGzYk4VppSeSMxmg49E2Mw
         ywig==
X-Forwarded-Encrypted: i=1; AHgh+RrdjHoMGW1D3LcK6G+cZHvdyKOzHSd2oD+TF3pwHgFpIFUhmisy/qPlpzIo9av5N7KIwHIKbVXRIAFWLOfm2nA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzqcv55j6LTDgsjLe2Mnlvwcixj5XkRhGGLtXepnB5Gr+0mlwCb
	psm2wQndgz28vnBKLtwZatg3U6E72JQn4o/062GnDR3kPShtB+0495iz
X-Gm-Gg: AR+sD13UFdk5NnttFPrN5q37AtX0+M5vGeXHGeFLZb4GEWwLXk/lSFg9ycfYeb+AsPA
	3Lz1ZXLvxf5ZGtzt47B3JGWttFue9rgt47b0ehoT6m+1Ix1NivG7Vtc2bLz9bEc0vph/2jqo3t2
	Eot0jF+Ua5Y/By462hDcTalXKEzLZc65CUksqfDlD2DRBCbeTNm6Y4LV5fpq6ewILGoN0HEfBIr
	BEWUcSQaZVLE5FS+ugZ1gbICkHyA9nSlNuxDQp3QWn7A6fm/YQSHK4nly0sGzLzwKy4PnRN9FSx
	qsqbLEra56813AFiwePNFfCr+dEMRzXeI+2qWZ49UEw5I3Z8W90rtMVBDmqzVKxQM1KG/yQFXkS
	39h8cPUApBP3BBJcVCKjDzUENhuMJiXfanYKUb9vW3MpNQxim34CsdAR8+dIPBu9Kz8BilA85YW
	fHFGgo00/OYrxv5Z4rKBdqIEgHt88sfBROQGaAFXu44jGC65dZpUOexBTFedksHbyJgFRsh+uXb
	XAo2nd21OIypef5Zy0pmwdb
X-Received: by 2002:a05:600c:3b04:b0:490:c6c2:52 with SMTP id 5b1f17b1804b1-49959e016f2mr415589885e9.3.1786380971109;
        Mon, 10 Aug 2026 09:56:11 -0700 (PDT)
Received: from [127.0.1.1] (83.31.73.193.ipv4.supernova.orange.pl. [83.31.73.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm238472635e9.2.2026.08.10.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:56:10 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Mon, 10 Aug 2026 18:55:39 +0200
Subject: [PATCH 6/7] dt-bindings: arm: qcom: Document Xiaomi Redmi 9T
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-next-patches-v1-6-79a779d76173@gmail.com>
References: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
In-Reply-To: <20260810-next-patches-v1-0-79a779d76173@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Adam Skladowski <a39.skl@gmail.com>
X-Mailer: b4 0.15.2

Add compatible for Xiaomi Redmi 9T NFC codename lemon which is one
of variants of Xiaomi Citrus lineup based on Snapdragon 662 SoC.

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


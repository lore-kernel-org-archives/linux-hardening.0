Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD84842E8D6
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 16:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380972; cv=none; b=LhCNVRDksaEw1gt9N1VTg2SJjeUJlNMnlkAUT7PronytvFAJ78zJ4FyLXlcU44UoqZX4jfHe0YYBA8m4UW8CnkmJZahjZ2GG2TpZO+AiKxTbKzssuyOlW7djjkW8YW+B9gpDLdq2eQCm5rkSX7uPQ+WrnGUgIPvTAKknd4KdFi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380972; c=relaxed/simple;
	bh=rQ8QaJNg7DR+O5snF8SeTz9/FRvBNXydzduaI0phx6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a/6Y/hNJ5qmSNDLZRAaGYz/qq73k1uHCPzWuRpatamb9bPQEUFIS7C77k8pPKx7irxpe0vIw+Hk9TbHzpu7wTJckV+v09CF04Vo6g78+AY9JUBvMyqLH4EeeCl+cUZg8OM7Z9DMGjqfPoasUX7SHy1PNa27/fdnswV+dNbs8Os8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bgp4O2/i; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bgp4O2/i"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4957eefd361so15510545e9.1
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 09:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380969; x=1786985769; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wpkqSlWYU2Zu/Y9vZRLFbjkptzRsUkFruMKaA3Y+Tgk=;
        b=Bgp4O2/iesN8qPoWuDpjcjEBxNeFaXWfdoluYdhXsBB9rTVyvwI4Eii8HIkS0dqrOe
         4r/Rl9WC1T4cw/+7hNp0WDPFSN+0hltFn5EDwR9FOZkYddseXfEBzd7bMfA/iylOoiHs
         2jzLMJmbl3425HcsLUGLOHXX/S/CaVUR0CSgSfRyzMCFD5ZkZhditcgnXbRee016NtBA
         V3DWOX425EsdhnuxZk+Juobfcp8qKsjx2073yIBPNnh0Fa7uq+BAVMlQ0HUosp0Q7Ws5
         8B1n/3x1zhmd45l+kPuPIvMeMidgksZTPcOXuEDSGcsf4W2ujpvLJoxKYo0PfKrvTojP
         MXVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380969; x=1786985769;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wpkqSlWYU2Zu/Y9vZRLFbjkptzRsUkFruMKaA3Y+Tgk=;
        b=JBw9rLKXr0mjBt21tNrQcN1hB0iDfsJDNOXnXzeywSAVBzOjynFBbRiZgwSoX/y4ao
         lNl0QWvlKMPVV7OcKXZpRP2DAFAS3j2hIFaO7RX8fVyYqSPaqWwGdV05P23P++6vT7FL
         wX5rSl/yEeT4UWUE+Cesb4HqXNj+vMc7miEpTt59sIjqzBm7fXtCjypnP6fIEDUPq3pr
         YGSX/0kEfueD7Ruor3nNNPDAJfVKaPfAqBdnfXw9KtacxL/5mxJP/26zsgSWVCyR6+F9
         o/tj+mOGa6tS6bZqDjkr6QXf8TMzaj1I44TsU/+dEbwBsWgGbZECvaVrHk2doDhwOszM
         AbVA==
X-Forwarded-Encrypted: i=1; AHgh+RqYQzlqyfuar/4QRnrRWm50MmtIdAnvhiqi8AAUoQxNwwuYsmUQtk2Fy2HbQkk51mMh1e/slGUy3dao2GZe5LQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXXTLAPLRRDuHhJpXtODknUe+KNuSeUZFEyMBmHRKtkDiyK11i
	hHaRNfutcc+GDF0ZlHPhMVCbGVQTMUWhne6S6P8mKHMVEiI+Q+EdlcwC
X-Gm-Gg: AR+sD11/xVmz2wYZGqWDvu+p8al2GmMEuT18HnCenubkRSxMYHv5PwA88cxDbUHguYn
	EiBQ6hh+Rj9N9hDXbLEQt8xNGmOsFCZByC62aHF9qqeoRk3sG42bBcxXKaikY+VgrukcB9OsK1X
	dGjIb1ofCMxXl1xfB7vt/73DyySnB4YL0n1+X2fMCEK85WFMWdVeMx9vmazakzjnMSiHDnii2ao
	JgQOqkXCAfdZKb4ixRCcsvB4/EUBqkuNmAKL7hZEdZ6+z87faHqpQOg9KgEGPlX02GNu5oFTEDy
	7jl2dKOjvrjneggfCoqtgHiWJLlDos/XzhwkNGy/WVkHEOPyplNyo7yhVxNvP4MtTP2hS78pmco
	JStXRfaaT+Vm3CuMQYrPunxBUyOSUQWf/yYiMDMZhgVCuVx5I3zMt9Sx8B9YwQCD9dy0YnDU46m
	L+IKRxWGrw5QLm1u9B7OP669/rCAP2mLqYCFsuaLgLGbSw/Ysr/0yBRAk155w3281XoV+jnhWNV
	e+jQX9HX/KgkHieFRaHtx4n
X-Received: by 2002:a05:600c:1553:b0:495:3da3:beb with SMTP id 5b1f17b1804b1-4995e0d0182mr304436635e9.10.1786380968973;
        Mon, 10 Aug 2026 09:56:08 -0700 (PDT)
Received: from [127.0.1.1] (83.31.73.193.ipv4.supernova.orange.pl. [83.31.73.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm238472635e9.2.2026.08.10.09.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:56:08 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Mon, 10 Aug 2026 18:55:37 +0200
Subject: [PATCH 4/7] dt-bindings: arm: qcom: Document LeEco Le2
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-next-patches-v1-4-79a779d76173@gmail.com>
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

Add compatible for LeEco Le2 codename s2 based on Snapdragon 652 SoC.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 289a3de1d24b..68542f76df30 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -348,6 +348,7 @@ properties:
 
       - items:
           - enum:
+              - leeco,s2
               - longcheer,l9360
           - const: qcom,msm8976
 

-- 
2.55.0


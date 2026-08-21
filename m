Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E90486E45
	for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 11:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312207; cv=none; b=scGAHDuPgsLlUZjd0TMYujfE1un/cUDeFfSBUXP8yDFhntD+SBUGYkoHsOPwH4fjUe5vkDXuJS9wuDryB/I8Bjmxy+Cwle3Ofw2tfSjtWm1S62VU/LT5yBtQe6ewawXUOBjrItVqu6HtAGwtE7nMVZ+f/uOXaMg+fTgr5SHG0hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312207; c=relaxed/simple;
	bh=lvXJIYHg+Za7wwIfyKwrdptP8jCEhBX03Cv8tnpa48U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VbdfG3fVCPqFc/StxoZ2QMEMLDi48eZBHEIJl4qEEZXcXVuqi2FRBlN3+gVds0TGB9D9sZCgv1zuob44m5ZNvnEdzrz8MZUYx3cQl/5aez9wIO1Z/q7Uw68CUr+G/a3btqzUxtWGjKEZ92ElMiq09Txe16/bNBjOicuw7SaMjAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/7FjvTz; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/7FjvTz"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c2020421077so153929766b.3
        for <linux-hardening@vger.kernel.org>; Fri, 21 Aug 2026 04:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787312204; x=1787917004; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pna/XzfqXxr5JhHe4C9RpqDZzth/Iq1szA4HTr9J/M4=;
        b=k/7FjvTzxGwOMerqKVcH/tvznm3QEx6uJ3E4sr2qUvfwzlA2iCXw9VQ7iXIfyquInD
         0vfuxpCetQZI5S2EIk19N42YAu9aszH8586iWBybr+suXjSCSKR1uJcNWb5/cyLJNM/Z
         5RU9piVX3ERvP/hJCpQi3OrHUnGbZ240eCqKnCduEf5vJdNQKm97tIrrQVo8CMOi4z5X
         CXtC2IuB1qJMpKeKuWZwkci3q3y9q8SqzcF9G05McC2APyhLzkwFJGC6y3RWM3IXWa6B
         DtujIqDGozc+ISPfyXA5ltsFmkvQJjQ70Qe2LY1oKhGmrvxNAXPJnBtDowK3L96YqbM+
         9ZmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787312204; x=1787917004;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pna/XzfqXxr5JhHe4C9RpqDZzth/Iq1szA4HTr9J/M4=;
        b=VsWHzlscKExucLFuICZbH7VSJ1zsd6oRW4jHKoOhfl+6eMw9IG+E66dblNu2mhP8Bw
         g2KQv32hbAY+zRe/XQGhdAQvPYlafLTmKmyW0fPbJ4x+/tN+BNF871/abErEueHVC0wD
         j9/VDXv4W76GgoHG8cva1KmLdCoZJQ82pnR9W6/08l+cFHHp/pBka0U9/oE84S8+1Tdn
         XJA3elVFgFAOtRxC83cEHW1iAzWGqMFhgUsZmDL2dOQtxyDkfLrp6ltMejKTjImAVQAZ
         0gtwT/Odon59/NbQwFnTslKAXYF0vL4j7QqraztqonSg4PGviDxkW0FHdba5a9OTak7v
         i5+g==
X-Forwarded-Encrypted: i=1; AHgh+RqtZ/wH62ed2g0AOHKDgk934Ox+ljK+qNkfPbKNPbRtwmWH+wzn1ycq53GQqO3wqL/NGBlOawdhCsci48MISOw=@vger.kernel.org
X-Gm-Message-State: AFuF++kdWA211V4qESc+UJOBc/Rdoaqgz+1CGp4WXS6psz65GNz0h4/9
	+DCpI3Sl0RdESBcJcg4Cx/2QnYa4ufp3G6C73EsSE7+GB034+y9KXq07
X-Gm-Gg: AR+sD11MdfXkliJiinka0iyFqK8rIPelSxtKwwkTljYtxY3AdaTFypnycgbTDT2W20W
	Ra0laaQzr9rHoSJRO3al06xy6JDn9d9rhBJiiU5dEcI0v6ovuJUd6yAN17ht2eIBG5W7XpdVGkB
	3Dzw5QOlpJhC7+KmZJJZFB1V8AHshFRf2VvOevIEPJQ50ymQGwZpuvZEh16jCb34B8W+HSxLXDl
	Smbg1M8Hz9JD7zx0kykrDRZFYOXCN2uLV+2HuJi18x3CgGBJN3Z9nKE53XgaUfMBvtdUcdbdUul
	ktIIwLtiDPz60JY2gx0dk8MbVg41zWiQ8c1Sq07rUVQmEnhPhot2wPaw5630qWkjnf9W+gMjMF2
	BaMUELSeHcretYJYp0QfXj1DduJWU/awzKR0+QAHLZt8ED/lCojwMtE4kREgsOfhXGdY83PP46e
	sodau3JgoxrlcI0l1e46CBOL4+2AnrryyHPK5kAzGUdrzIytmwhqPa9cPtqmQ3GSVCfGnpbaSEU
	kUipeN+Q1qnnvw8F4TQMvev
X-Received: by 2002:a17:907:da16:b0:c20:f4ee:7c97 with SMTP id a640c23a62f3a-c246a4aa1bemr559160166b.5.1787312204319;
        Fri, 21 Aug 2026 04:36:44 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff0c3491sm6204661a12.10.2026.08.21.04.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 04:36:43 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Fri, 21 Aug 2026 13:36:28 +0200
Subject: [PATCH v3 1/7] dt-bindings: vendor-prefixes: Add LeEco
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260821-next-patches-v3-1-cd64bcef6e21@gmail.com>
References: <20260821-next-patches-v3-0-cd64bcef6e21@gmail.com>
In-Reply-To: <20260821-next-patches-v3-0-cd64bcef6e21@gmail.com>
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

Add vendor prefix for now dead ecosystem company LeEco

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 136681412501..dd0762d3334b 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -947,6 +947,8 @@ patternProperties:
     description: Shenzen LC Technology Co., Ltd.
   "^leadtek,.*":
     description: Shenzhen Leadtek Technology Co., Ltd.
+  "^leeco,.*":
+    description: Leshi Holding Beijing.
   "^leez,.*":
     description: Leez
   "^lego,.*":

-- 
2.55.0


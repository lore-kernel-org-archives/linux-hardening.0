Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46033FD121
	for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 09:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787218972; cv=none; b=QKbKK5v9AEFNLa3wpYXfXRn7hfYyeyFAN4UIB67LgK1KggtVZs+cxojZVyvzaXRpifkKB/8NcKpA8B2WfoN9GuTcuk+bZufqozOe12t4/sresEidHt4IsAGP/VBJ+c8vMyhiF3rGgjGlp0otdYhaFa3Zz8WvtB/TExdaRBs+mqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787218972; c=relaxed/simple;
	bh=lvXJIYHg+Za7wwIfyKwrdptP8jCEhBX03Cv8tnpa48U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nlVfKCI9LW+HtVFGUa8UFk2BotFJ79IE2fZvB18ZLCzx32FCVMqNxa+8iP8bHarG7bk8xCdZ20pZnCtA+tg40+e4S36s78yW73CuUztWcG8GhDpD+WbuqyjAYgXULsGKdglp8ByT3eO0iaT2JeP9XfRtgkrQ24I9aPFEH1R0ETM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OmSKwNBf; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OmSKwNBf"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-49556f97a9dso13904015e9.1
        for <linux-hardening@vger.kernel.org>; Thu, 20 Aug 2026 02:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787218961; x=1787823761; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pna/XzfqXxr5JhHe4C9RpqDZzth/Iq1szA4HTr9J/M4=;
        b=OmSKwNBfRXl3HffmJ3Zgtv9O9cXY9ahV1itKzw+q6P9mVQo0A5qpTlh1/xhuVPnzmu
         0uP8UTDiP5HtTjcXSlKWFQyFUE5Nwu+AtoX83t3dhSh17U+cSMFIp26wDdJz7asN8eDh
         kE+FtJD0mxIN1I4hQpwfwlGsfMQVW0oFAvQRxUhWVusgWrD9SUA9dQozJco8/nZllMiA
         qIfzaeNa9y1Gz5WPMPSGm8kyUNdke8z+Wwori8GsBhcrtNlNZpAns7UuP3MqNxJy9x3y
         xQ4jsWhy0v14jt29yau0Gp3WNFCoI48UFhqAduYzMp+qNV82r7hlGNfNyY3FzaypB5Mk
         XtzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787218961; x=1787823761;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Pna/XzfqXxr5JhHe4C9RpqDZzth/Iq1szA4HTr9J/M4=;
        b=LnR2ozFYCLex5jvjm+NbZq5w4UTyw8BMkPos0lhZowZcFA+WkvXh0NIO+RzisBMWs6
         kZlMVqFy/UXGxf7qpQjzt2nPLr7B5tSu2DdfpYqDfpYffa7o/hKG3Nt/uOq2i/hX5QjM
         fOb7P0LzaVOAEvPVolJIpJRHcpxHzrOiiQ2uolGobZdJw/vJgqMbsmkwQ4qLGNSUJ6O5
         8QQxIf7rZixc443UkDCjiUiYcVg9KLAx2Fk13cAD9yIH5EMymeYx0d1SRzVjZ0WFJIBd
         LNiupiwg0Vdr9NuiGos7fAmlnqO8bKfJLAFXUJIljYQ8M0ePSQ2LUq39VNXHjykrZKHf
         6fqQ==
X-Forwarded-Encrypted: i=1; AHgh+RpO1Kje8A20Wz01dlO4sfh06rndHt6RZ3y6rcKsf65hGR475yhXoMAawAz3PjxQgqjXNqeZvcuo8TmrGIKGUt8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMip4QV4SABPy0h7KRkmkg8IdRSAuuFUvlhfvxiRh4NhGVzAwM
	OSBeiYdfxRmbOkeUt6BLZM+to9iqUnjJRZqkrIkpiZwKCtYINdYZkN4T
X-Gm-Gg: AR+sD10YtzVMddKQ7Xif4SBbAnDbQjd/iGn5KwC5rewGf0Gl+IiWqh9my0ILczyTj35
	oJuzUk+BVFNRdZnJpriSVWZXefg5Vsv0z1eFBdZ1IO8VNQ1itV1S/ggS7Ocq90pQVYlvdFheRj6
	9SeKpcKbOO5LSPsYxE/7aSh4jNDhjAgV6W/ocYFO0tJkLX04EvnGmxX+oOFuHII+RtlHpqNqFJa
	YWaVkqqDoxgbCV/MJg3W833qmYwCtxWAjlIw4tPmyDO+qdZLsoMr4ZINHgCBGw2rNn+EZXRkgql
	Ejr+LEPF2VqITXU10MGZm9chdYLJ1jcpus8XT/dmvIDLHfPwmJy6wS7aPaIPk3raq6lpIdohbMK
	GaV/fkjUjiq6beNqZIn0V3hUKkLSkFV7Z7odE5ueQ/Va6VtrhBdH2y/8LWZE7UQDFC20j45FK2K
	VGxCY4vXck2QaOKCBYUiYa7pd+j6vlbal1nKs/6tjSQfItQdfzcQL2l/Ifw6iEOEB3QfOUwfrrA
	HCtBQvA0q4nojJRnB+7qpX9
X-Received: by 2002:a05:600d:19:b0:499:b4aa:3d70 with SMTP id 5b1f17b1804b1-499b4aa3dd7mr11458805e9.14.1787218960974;
        Thu, 20 Aug 2026 02:42:40 -0700 (PDT)
Received: from [127.0.1.1] (83.31.75.144.ipv4.supernova.orange.pl. [83.31.75.144])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482b144173csm11788090f8f.6.2026.08.20.02.42.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 02:42:40 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Thu, 20 Aug 2026 11:42:24 +0200
Subject: [PATCH v2 1/7] dt-bindings: vendor-prefixes: Add LeEco
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-next-patches-v2-1-7130d68183d9@gmail.com>
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


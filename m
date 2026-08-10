Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C542DA31
	for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 16:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380967; cv=none; b=a82emZ/IdYz6AXog48goORz/qv5s36ofMwo5H7J6N6cvurnE9s3VEyp184RH8QbjXLla/kGeL1xWHmpfe8ko6HpQMFS2ui3QuUD571pgeRBuyOM+fuiFWTdmUKUiwlpAJyYpILTGQ+6rBquNllTg9bN4JIAw3XciNAfYYEPB5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380967; c=relaxed/simple;
	bh=1QK3cTT2t5BsbTp2CghYM4pnPFZxEX5FAMOIRXPEdno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fB0UL2wsEwMwFi4t52P/+sNxXCu8+MA+D6ajQmXqBfsD424FkDm5lMGGbvbZLCUwuRJVHqkjFPAw3U6cOk7uv1ZxT/T7Kapnc6jZsQUkhSjAe2wuy/HnP/PWU/CP4v476o9K62gfHI6d7A8rYshooFCtazqhvNKx43HE3Sr8RXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gXK4250D; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gXK4250D"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4956869750eso13887775e9.2
        for <linux-hardening@vger.kernel.org>; Mon, 10 Aug 2026 09:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786380963; x=1786985763; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bsOwVJwKnJHY2ExLl/CYmRtzOXIqsyEdBUQGA5n++9Q=;
        b=gXK4250DU5xEwzstcZMuP6zi4jo7P3WkZhUYSKiiwGeYCc7ZtGOrHs+vOQxksIm9HQ
         YZ/q2japhMkqhGeBBpU/ZkCthSrkuO8OHzb6rSo+RC0Hyf2QQfG3n4sYNwSOFPzpfHYE
         xlkMppRGopi0A14U3CzsR9UWi3qhHKjQChEUN9tbkQsghDU84VJUH4GXF1rCAmRS8zQR
         qhhonx0F09gvH+F22dEYgw+xwBJHIzYV/9qxW+kxakzT61zNg9Z6ftCyBugQeGWlpNqX
         JmsP7FFOzY3DwPASMm3vIkR5Een3jOY1rAIzBMipF1olArGNoC+U/o/QaGAOpkF+jaye
         SGjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786380963; x=1786985763;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bsOwVJwKnJHY2ExLl/CYmRtzOXIqsyEdBUQGA5n++9Q=;
        b=KeOPXVhB8qU2ee4GqN28bNVYuUZ4CXnRjQqUXilWtnkrlRECFTF1kThwRBLlzqsghx
         NEU3PcXDEjKfsbuO0n+UfDrfDyMVh+gO/pYf0c9yiFCLoafl+1yXdOgCxgdZmdv2uSpn
         MQGqfVrZBD9cUObt+l30PiGjI94rzMiAuIrQh851PWgTSI/HZm/sk1PWCTtGduZy8Unx
         kGqJ2m4CJZlG3AspXUM88GA1lcXKyamPFHl53vGl34mjPzGDQBo2yg04IUlAHXrxh7L4
         RKvjrLy4jik0sDmnMrcUnv9NxgITVBGOPkcIM8+D8Q7+lVcWbKj2bbUx+kvRsCNeM79U
         H7Kg==
X-Forwarded-Encrypted: i=1; AHgh+Roi6Oe6NdfTaNged1uAgUgSruMl3+N3iFwmuSf02H4jNqNEksSCz1eGbroAkJ8VWeW6M9uMIf7cvLj+LNDoJxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMLsdw5MwouHg7q3si2S/LCCDtn3VcSfSpJGQRZx4Ld+ibyI0M
	veMyzE0tK3xVDDD/tDY5GY2yz/CaTKiltgj+cFMDE+IFo5h4lcDjP05q
X-Gm-Gg: AR+sD128XSQyz5gf4ziGawiKVeviOnpX+n1CuPXyx8th2OdKNv41sLZmXHizSlVMdkN
	PwDUHzu5uCYG5Qmq6Vohqu/k17NZVqBaRkiT9PgU3GQp5oqsomJntzGuDAnkibMxe1n80y5Ck9T
	aIkI/RQ1T+8PdeHkCYlV1w8fbpBi74udPDt399mo1vpioZWJLvaQ0Yfv0LddipoodfzA35GK9wF
	UwhUooyDOgbOFImB/dfObDzUDpQDuUqC1jeO7G7CIfa0gWdVbOht9Z6Wgfc8Iufrhjy3ZfzFEm9
	H5GCgMILg+xuRk/IpVGpvIphftqFnC2UFrI+JSnz1P7iPyv7B52ELWJnCC98k8d03joj42IBjfn
	pXvRM9yJjgyTUygEJcydoyzJt/IuVA3OJVok/3+9cOrU3YyLKB8Lar22VT8Aud32QGeVp6qMzLt
	yi0q4nUAHklY8kJOCUP3U6cIHP6+w5fDrfXm2OeZD7DxINPMWOraINK1Rs01AupvAG3iQeYvZO7
	ia6LoVe4gh4TguLl5/P9HKw
X-Received: by 2002:a05:600c:5489:b0:495:6134:6d61 with SMTP id 5b1f17b1804b1-499727d853dmr45181605e9.19.1786380963049;
        Mon, 10 Aug 2026 09:56:03 -0700 (PDT)
Received: from [127.0.1.1] (83.31.73.193.ipv4.supernova.orange.pl. [83.31.73.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995c69c8ffsm238472635e9.2.2026.08.10.09.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 09:56:02 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
Date: Mon, 10 Aug 2026 18:55:34 +0200
Subject: [PATCH 1/7] dt-bindings: vendor-prefixes: Add LeEco
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260810-next-patches-v1-1-79a779d76173@gmail.com>
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

Add vendor prefix for now dead ecosystem company LeEco
Link: https://www.le.com/

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


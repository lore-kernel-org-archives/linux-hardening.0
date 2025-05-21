Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913A8283691
	for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836634; cv=none; b=aR7LQgeG9T0Okawu7/QpWQMfksGFMBKZDUM3CrpJ3PhMkzAk5MviJKBDPQG7YtezW5o2zWFhJlDK1dXuiGgM1NWMO9v2Wty5STbDh4p5uK0IsAprZZcVmH0wyeHOTwqICmYHCM9irGZTN2HPP10URemrkB2gviPC5xpMxnbl/1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836634; c=relaxed/simple;
	bh=XODCdlQ9JYoDDsNnzBn69mhkXEts4CheV3BPuja6CXk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAfPLv0GCqvQFjo6/aT+NQPJe3sG4sPjz7w6EUwcpS+w/GZihb9Qw9nca0ARiZq4YxBpg1ONC68PZ8MsIhNY9R4oxp5E3EQ6LofRXURe915L6GGJ81YOP58z/n9+wm5lRXZuNmBuTVyKchykFUVOq0mlXfwOlTmH/i8pnVSGlnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=kiCJzjj1; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="kiCJzjj1"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ace94273f0dso1181276866b.3
        for <linux-hardening@vger.kernel.org>; Wed, 21 May 2025 07:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1747836630; x=1748441430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cl9iumKUHycZw2LuiJs/rBHFbGkhee2I0sRJSJxgwN8=;
        b=kiCJzjj1+b+2gshqh1BVowefGSNh+DS6L/pt6DEPRyETPwmwA0qcIFqCjO1CLp7b7S
         kXr33Wea03BSdAjgRwHAlgPwPWuBtnpZH2vxpXNdoo1a7bWeo5FPC5Uv66RLKQoRZfGC
         FOAgKtHDbafA2wTOhv/3DPSaMWPqCpk3cCxZtce+CY9mLc/2NXwv8WvNZi/30v7vVdhH
         pSorLwMSQtLhqPLK7X5sYdC7RhFO/IPqmawM02ZrmIn9ilOGN1pmxC3UH8bIZwyXxJF2
         R+0Ye1UV5ctyPEu1ZYU4XpdfdTSVilJBexErKYTGFu/t8BFaF/QIOV582aXYceRSkwPe
         3Mlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747836630; x=1748441430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cl9iumKUHycZw2LuiJs/rBHFbGkhee2I0sRJSJxgwN8=;
        b=VLkIQ1wGWd49L/+v/VZfl/zD/nQcUbYOWzW/A819w32mrdlTfhdtQ+a23oRLDcHPeG
         wfcj3vZzDKAwm26VCs1Ju0Vp/DpSvcTu9HKgXGNWyMe7aXhcVsT9RwYcb2NzrciMwb5Y
         PjJV8WXGwZnETvTNN2FjhZmmrIjfxXHQk7U4HItvF63ecsTBWx5vN5FOdLvFvj9XKUZl
         EzXvhw2XFWdRIHjIVwu+jATbir3HQcNy8B/FTeyHpFJiOovgE7qvBujMHktOXZrtINBU
         +ml2FkK3loq3u+gFhjarnYNBsea1IkWXjs/jqexoU78biBjTaMhO7OPv5HQL5I+jPYTM
         8jQg==
X-Forwarded-Encrypted: i=1; AJvYcCUJIVToKQvwlfCTMNNHC+45yn7pMTtufqb47za+IAs9FRcXuV4DgTrJ+gVQLkznZg+E2kf9e3MgzstZCZUF2FQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRhniBb5uRA/w4p7nKjYTduBRXsMNAh2A5DHxeyehi7Ro8dj68
	Ee2rTPF0rEgSGuP1f5lmQ03z6tENw/WLYAVb4MjsdJWqFhe3MC7A/xbaH85uLjd4YExvHjfGxs4
	5Bzvw
X-Gm-Gg: ASbGnctgOX3cqm9V0YX57sTereUnbwZ0Z9I8P208oSc+CFTJWN+6/N1aIRpO5otFL7J
	BwDfX7ThZ+c+BUwPXbh1YtbjHxfSxBKtwDayZKSxKdSB3VuL6Ta6KqPZx7KY3SZD+S1f9m1C28B
	NZrmwGq2sw83sV11MjfG8JbaggviYCF/Is1HovTYKwD2yYLVwvA5RRODRGiI5LWjRAe0G7lYVVV
	3ioVA5/3T6pbGI3xB1TuBY28CwZ9+Uy2VRXhsq3OnIQry3UkYIcXWL0Wk1kBiQmJ3rexyP/rzSJ
	nPzRy84K3eOdv8afjOGmacRn1g8KDvZiEoz4DPi2Msw1WZqkEuEoFCLE/6KsrSQpbv2cNSfO1AF
	8Usqc2pi1W4BX6Gs=
X-Google-Smtp-Source: AGHT+IGD2TFDUAmZSCVXr+Ck8MJMzjDFoIU+oJlf9NZINhEoKVsrTuMXHWv6l6Kj+MwSbuL8IYJrfQ==
X-Received: by 2002:a17:907:968f:b0:ad2:53fc:a884 with SMTP id a640c23a62f3a-ad52d549101mr2012530866b.29.1747836601240;
        Wed, 21 May 2025 07:10:01 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.58])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad52d271916sm914552866b.69.2025.05.21.07.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 07:10:00 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: vkoul@kernel.org,
	kishon@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	p.zabel@pengutronix.de,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	yoshihiro.shimoda.uh@renesas.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	biju.das.jz@bp.renesas.com
Cc: claudiu.beznea@tuxon.dev,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 04/12] dt-bindings: phy: renesas,usb2-phy: Mark resets as required for RZ/G3S
Date: Wed, 21 May 2025 17:09:35 +0300
Message-ID: <20250521140943.3830195-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250521140943.3830195-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250521140943.3830195-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The reset lines are mandatory for the Renesas RZ/G3S platform and must be
explicitly defined in device tree.

Fixes: f3c849855114 ("dt-bindings: phy: renesas,usb2-phy: Document RZ/G3S phy bindings")
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v3:
- collected tags
- rebased on top of latest version of renesas,usb2-phy.yaml;
  Conor, Geert: I kept your tags; please let me know if you consider it
  otherwise

Changes in v2:
- none; this patch is new

 Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
index 2822dce8d9f4..12f8d5d8af55 100644
--- a/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/renesas,usb2-phy.yaml
@@ -108,6 +108,7 @@ allOf:
           contains:
             enum:
               - renesas,usb2-phy-r9a09g057
+              - renesas,usb2-phy-r9a08g045
               - renesas,rzg2l-usb2-phy
     then:
       properties:
-- 
2.43.0


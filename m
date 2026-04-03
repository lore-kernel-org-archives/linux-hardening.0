Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1046A3C4559
	for <linux-hardening@vger.kernel.org>; Fri,  3 Apr 2026 19:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775245642; cv=none; b=e0/RXic215BBrb7f+ODrGCc42sTFBYxYrPy8v6qe1G2gH+it4jYMxq6OatYrvYiCGIOxzY/qsidJu9exwoMLeSiVOhtJ4EkyQuoWU9cOrzP1F6DDW7q70IjDk9tyGcrY77eKSDirU2n5ygdvzd5HdySzp7Dckx7EkroqwViRmuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775245642; c=relaxed/simple;
	bh=JWztFn3QEi7ajg35YZdZSubgv2uWph0TudqGlGgdsD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eONIB7/tO5u5fuegQ+WPeBGvqdvm4aOGrv2u5AubVbbg67PzsznOthyPRE8l/CV6BOzrDamw361naFwwofcnK8qWoeMBgSq+bmeHpCpYgLUgUjP8ilC4COIbNbcleJdHDfjT+iTRfF6kYwE/AV9nAdWj15e4LCJY6h62IpIO8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fs6HG7mk; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fs6HG7mk"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ad9a9be502so14336025ad.0
        for <linux-hardening@vger.kernel.org>; Fri, 03 Apr 2026 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775245640; x=1775850440; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VsvDVL5tc5VALviYh62qkT8pA+BxF0TiR0JTDFx2wc0=;
        b=fs6HG7mknNHopzWy32VzYYaHNpXpyZiCeEsaLdlOjjoZmz098ugees53IKljPGbcYH
         7Uv+0e2BroPTW2y1sbGrwBdBw/0oATaJXTg3l9m+JtmS2nx5nGXEU3cHTSmvKUsm2Bwj
         WkKY5OwOnmi7tBShLnpaX10B+79gOQ0/6Vxf1ycRb1mDq8vuaR1v+FTUjWiV8L1aneGv
         mwe3KSU9oMEdju9FzLu6Oxf76DKPBrPNXuw6YKYblP9pU258IA3V0RcrUCHP6HkZFqx+
         r9kmDZYOK9Qw21wJBsrkV8L9W73qBZxzPk5r9sod2CyYYEGimVtXWog8gWchmbDnI9Fv
         +HGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775245640; x=1775850440;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VsvDVL5tc5VALviYh62qkT8pA+BxF0TiR0JTDFx2wc0=;
        b=eTZi4yKIun8v0xevzFIkBtzVb9Gd5t+5a2eRREYY8CZAnlNR/gIWqB/SuXoN1ZEoAp
         tU+HzuFi6JPxDckFSxF2Nm47uyuyocvG/BcHSOez38ubOmEh75/3bYOCP/BBwVswD5Xl
         e/oJGvKkSXu1FxhSGFWTxKoSDyJPZg5T8ChaYWWagp48sJuqsiiB8gDiscdORLip/4wn
         XKCQP+IRKBUd/ualGO4c6zmT566x8QdJ1ONODARKc2e2AUjrRA2uSwRFB0ziQIEg8Lin
         lnWRZhNPU1RP/1+6yq09wrJZQ7i7Z252zLAWQvaxmp0SgfCP/NtC2CB3xOv6ieQtrs0b
         90mQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDslC8yl1YezMX/19zc+csnStq8Ru8cjV8LDQ1ofOvySa6oFZj8uaaUL4mM30plUkVwbMXJsn08n5bcAAQzHM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0TsKNsEgV/KlM7ISfLcktKC3pJqTGWUPrz7M5eTgN1/aGVBng
	L6emrXjwS0IZe8HcAJ0kJjxZazGTtpNuXvr6glLh/KHjtIEu4xTw8dc4
X-Gm-Gg: AeBDieveExvooU2JuiYZabNaY6O4Uv0IcYvSVznehh4aIKNajlcCdrj3Ln3xzFc8wtz
	oigzFXJZ/uGVVsuUlR3TMag/+WS7eVrC8ZdTZoBDMJEO1nYG8n74R/iiIyEQXbFOkqv8/K+hJ1e
	jonuN/+vtZ3jAFXePnECQ6AguUN1eIyAXVHt+aHN22m0LExhQ3kEd3UpctxgIKSKpAVCWG9hbYT
	2Wi8TSjUYssHEr8l4uqYECYDorCKCfp7YXb9JGz4iMUZfGd7262DKmBkWGjdM6JC2m9QmvqTN90
	83YXPRpTrzfwSdAJXoqaDSANu5BaUJ46u+dOKjuDxAT0/H52cVnatVIXX5QGN7zEUf7DRffIuWg
	R+o3QeP1haMGiekqeKBI72bjZEesxT0u7rWlPwT4sZetoM0tzA6EmIqff/oEahS/zZ0ANANk3fu
	XCb8BQsDBS/C4v/cqX207BGeocIW/wamIgu3czpr47B4Ci5Q5NblwYILA=
X-Received: by 2002:a17:903:3c6d:b0:2ae:8272:deb0 with SMTP id d9443c01a7336-2b2817361c8mr46732635ad.15.1775245639256;
        Fri, 03 Apr 2026 12:47:19 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27472d54bsm62706225ad.1.2026.04.03.12.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 12:47:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-clk@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-arm-kernel@lists.infradead.org (moderated list:ARM/Marvell Kirkwood and Armada 370, 375, 38x,...),
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCHv2] clk: mvebu: use kzalloc_flex
Date: Fri,  3 Apr 2026 12:47:01 -0700
Message-ID: <20260403194701.11902-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use a flexible array member to combine kzalloc and kcalloc in one
allocation so they can be freed together.

Add __counted_by for extra runtime analysis. Move counting variable
assignment right after allocation as done by kzalloc_flex with GCC >=
15.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: remove now unused goto label.
 drivers/clk/mvebu/common.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/clk/mvebu/common.c b/drivers/clk/mvebu/common.c
index 28f2e1b2a932..0f9ae5f5cefd 100644
--- a/drivers/clk/mvebu/common.c
+++ b/drivers/clk/mvebu/common.c
@@ -189,10 +189,10 @@ DEFINE_SPINLOCK(ctrl_gating_lock);

 struct clk_gating_ctrl {
 	spinlock_t *lock;
-	struct clk **gates;
 	int num_gates;
 	void __iomem *base;
 	u32 saved_reg;
+	struct clk *gates[] __counted_by(num_gates);
 };

 static struct clk_gating_ctrl *ctrl;
@@ -257,24 +257,21 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 		clk_put(clk);
 	}

-	ctrl = kzalloc_obj(*ctrl);
+	/* Count, allocate, and register clock gates */
+	for (n = 0; desc[n].name;)
+		n++;
+
+	ctrl = kzalloc_flex(*ctrl, gates, n);
 	if (WARN_ON(!ctrl))
 		goto ctrl_out;

+	ctrl->num_gates = n;
+
 	/* lock must already be initialized */
 	ctrl->lock = &ctrl_gating_lock;

 	ctrl->base = base;

-	/* Count, allocate, and register clock gates */
-	for (n = 0; desc[n].name;)
-		n++;
-
-	ctrl->num_gates = n;
-	ctrl->gates = kzalloc_objs(*ctrl->gates, ctrl->num_gates);
-	if (WARN_ON(!ctrl->gates))
-		goto gates_out;
-
 	for (n = 0; n < ctrl->num_gates; n++) {
 		const char *parent =
 			(desc[n].parent) ? desc[n].parent : default_parent;
@@ -289,8 +286,6 @@ void __init mvebu_clk_gating_setup(struct device_node *np,
 	register_syscore(&clk_gate_syscore);

 	return;
-gates_out:
-	kfree(ctrl);
 ctrl_out:
 	iounmap(base);
 }
--
2.53.0


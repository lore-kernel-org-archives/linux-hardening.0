Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF69E6DCE1;
	Sun, 17 May 2026 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779058887; cv=none; b=RRfImrH4G5q/pHyC0rV93drIGGGvsjVSvPFIODJ8hWLj4LFRqUjt8HI/FR7q7aco9RZm8t6R8Rr3bhD21NCakBxRuZfOsBNf4Vcx07j88TI+5qr4peyM5NpfR+YCS7pF5OekldPoYHUoQpVHXsVC7m5lhLZwo/WWnmB9G4WLdf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779058887; c=relaxed/simple;
	bh=JRHUDPY0RjoebHFgU1pqfnIloCdHxtnP3wUt5sdsr4Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bKVJHnCuxaCtSBtFwJBnp6oTlXm11iiS4UqyyVi8QdqoGf0KJbnvYxRALStz15Hgc69wGimOmG276Uirdi+YOVPMaTniHx7Ej8Juz5PTfek6aqBUscq/CXLAi2SuyIRB3l2qCk0Cf3r+2bbZ3ptXl32MQkn4N9kmt6hmoEbv22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxefJQTW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxefJQTW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95998C2BCB3;
	Sun, 17 May 2026 23:01:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779058886;
	bh=JRHUDPY0RjoebHFgU1pqfnIloCdHxtnP3wUt5sdsr4Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BxefJQTW7xdouuyIIMitQ6fw5J8AzdHsy7ODhvpbfAs7oSaQwmg970v/VTIliTWzw
	 EtlJdWtfwE8TXxwtyWcNtBJ0332Wccf/Zi1jq717oyzMV5koqDzL/gEHG71PzRsNYd
	 GWwbSUDoFzceRwpJqVrZ/6lpf8oR7Z2udwh/HmpUcjnGq96e7usTAMI0QvlKM8+98s
	 gkK0Gnu8CoS6yr834/x3ztGnEXjqwEUKKhng8+n0/cBkGOyWjXTm+VL3ffW9+sLKo5
	 B187t1R3tZog0ds5VAjOCjNbZM8M1bUMuIoRifndA26Z+2cUfi6SbVdV+NxgsCcL6H
	 +mGfsaLGHbfQQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 18 May 2026 01:01:19 +0200
Subject: [PATCH 1/2] pinctrl: starfive: jh7110: Use __counted_by()
 flexarray
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260518-jh7110-v1-1-fdb0daae5a4b@kernel.org>
References: <20260518-jh7110-v1-0-fdb0daae5a4b@kernel.org>
In-Reply-To: <20260518-jh7110-v1-0-fdb0daae5a4b@kernel.org>
To: Emil Renner Berthing <kernel@esmil.dk>, 
 Hal Feng <hal.feng@starfivetech.com>, Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rosen Penev <rosenp@gmail.com>
Cc: linux-gpio@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

Flexible arrays should use __counted_by() to be able to do
runtime checks that the array does not go out of range.

Cc: Rosen Penev <rosenp@gmail.com>
Fixes: 87182ef0bf93 ("pinctrl: starfive: jh7110: use struct_size")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c | 1 +
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
index 3572e8edd9f3..3fb9aa8ddf07 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c
@@ -865,6 +865,7 @@ int jh7110_pinctrl_probe(struct platform_device *pdev)
 #endif
 	if (!sfp)
 		return -ENOMEM;
+	sfp->num_saved_regs = info->nsaved_regs;
 
 	sfp->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(sfp->base))
diff --git a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
index 188fc9d96269..12568be28527 100644
--- a/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
+++ b/drivers/pinctrl/starfive/pinctrl-starfive-jh7110.h
@@ -21,7 +21,8 @@ struct jh7110_pinctrl {
 	/* register read/write mutex */
 	struct mutex mutex;
 	const struct jh7110_pinctrl_soc_info *info;
-	u32 saved_regs[];
+	unsigned int num_saved_regs;
+	u32 saved_regs[] __counted_by(num_saved_regs);
 };
 
 struct jh7110_gpio_irq_reg {

-- 
2.54.0


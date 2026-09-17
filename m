Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9C3BB68B;
	Thu, 17 Sep 2026 21:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789679689; cv=none; b=eOVUtDiZGg7eA0jkMaNxc3dJ2nm6hb1uEMArWlIIs0BAaeScFeCoIR2R9pQwB4i0ZCtdZfQkxwv4QTGGMt3iigMfJd73+pQ+HHBqTletq+y2Hs3RrJJeHLl52H1DMHy/726w4DhiV7Y7IKsjZwgMP3VzkLX1O902uwfyiPWVOm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789679689; c=relaxed/simple;
	bh=BunUnZrKE5CuKsM31YlpSOJdYNGOyEsx+Y9i11ca+7U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QgUcmziqTWrVTUFnZaVhb+XzINX03JH0ymA5DV3ISVcnnV6LVAYVmPPF7cotJL9oAjl64PX49q91aXeyUZGEEWantoOqEY7MVdAVrU+j+ESI8jEiq3zBlgGsPFz5kP7iT3A5NGIgI+/k8g0qipZeONhcOb3swOqSLoYAf9iAK6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+Eku6Em; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+Eku6Em"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A4501F000FF;
	Thu, 17 Sep 2026 21:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789679688;
	bh=MxhYj/TCLftR3RtPNjj7inhN0NiI4tVG0507jQCqhRg=;
	h=From:To:Cc:Subject:Date;
	b=O+Eku6Em6poaJSB+sJt9uhb0C/4prcjcv161Wyqsr62B3JIG6XlEpC69XlQzXYInQ
	 pjWOXBEPX3YChNbCnQeJI15HwHSpK8PfCu6kLiYwQk5d2XtxAGJHtaX0I2cv8GQlSs
	 zcAmXl2I8kqD6GWbcskNi52ZUXBuWHo96GuK8GO+QqlGJ89jGDnb7UBKV8RmHMlB9L
	 pAa3Xdwjd33KS0O25/0AouaLQPVjqj9QtLLW+eFGmcDFzzfKB6qZtkXGKcnjUw/kLM
	 jzjr5xf7hFw7KXAIJpjZ9n/KuJOw+SMY11h6RH7YZ4yzcwLuVcEMbVgOV6mC9Uw5Ed
	 k6usDEUHuTp8w==
From: Kees Cook <kees@kernel.org>
To: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Kees Cook <kees@kernel.org>,
	Kees Cook <kees+treewide@kernel.org>,
	Fabio Estevam <festevam@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jacky Bai <ping.bai@nxp.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	NXP S32 Linux Team <s32@nxp.com>,
	Linus Walleij <linusw@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	linux-gpio@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] pinctrl: imx: Remove const from group_names allocation type
Date: Thu, 17 Sep 2026 14:14:47 -0700
Message-Id: <20260917211446.i.153-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1900; i=kees@kernel.org; h=from:subject:message-id; bh=SI/CPd6XS8ei4Q7rFs30/ZmKJ1M1jnctDK7KU6kGplE=; b=owGbwMvMwCVmps19z/KJym7G02pJDFlrItwsPm22mrBI0vl9duYClhDJq0/zi9zaT+pJfeX0n ZpiJdvTUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJEntYwMDxe/5a8U8g0zrjf8 +jyEbWqRs0wg+9c9SdXcH187qKk7MDI0NpnenPJNNSvtmgNDddMbV88qxn8hfFPvTvy/7ce5ZaF cAA==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

From: Kees Cook <kees+treewide@kernel.org>

In preparation for making the devm_kmalloc family of allocators type
aware, we need to make sure that the returned type from the allocation
matches the type of the variable being assigned. (Before, the allocator
would always return "void *", which can be implicitly cast to any
pointer type.)

The assigned type is "const char **", but the converted allocation type
would be "const char * const *", as the size was taken from
"*func->groups", whose type "const char * const" is const qualified. As
there is no general way to remove const qualifiers, take the size from
the assignment target instead. No change in allocation size results.

Build tested ARCH=x86_64 allmodconfig with GCC 16.2.0:
drivers/pinctrl/freescale/pinctrl-imx.o

Assisted-by: LLM coccinelle
Signed-off-by: Kees Cook <kees+treewide@kernel.org>
---
Cc: Dong Aisheng <aisheng.dong@nxp.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: Frank Li <Frank.Li@nxp.com>
Cc: Jacky Bai <ping.bai@nxp.com>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: NXP S32 Linux Team <s32@nxp.com>
Cc: Linus Walleij <linusw@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: <linux-gpio@vger.kernel.org>
Cc: <imx@lists.linux.dev>
Cc: <linux-arm-kernel@lists.infradead.org>
---
 drivers/pinctrl/freescale/pinctrl-imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/freescale/pinctrl-imx.c b/drivers/pinctrl/freescale/pinctrl-imx.c
index 9a45b376d36f..c11d220d982a 100644
--- a/drivers/pinctrl/freescale/pinctrl-imx.c
+++ b/drivers/pinctrl/freescale/pinctrl-imx.c
@@ -600,7 +600,7 @@ static int imx_pinctrl_parse_functions(struct device_node *np,
 	}
 
 	group_names = devm_kcalloc(ipctl->dev, func->ngroups,
-				   sizeof(*func->groups), GFP_KERNEL);
+				   sizeof(*group_names), GFP_KERNEL);
 	if (!group_names)
 		return -ENOMEM;
 	i = 0;
-- 
2.34.1


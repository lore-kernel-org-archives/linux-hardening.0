Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E0C487BC
	for <linux-hardening@vger.kernel.org>; Mon,  4 Mar 2024 16:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568418; cv=none; b=kNg1VIQxIeoUnvmBJx3x4KPz30rW0XQtYxX4nP8VA3nIla4Ym6UYc9p75NwyZDqYypc5zufJtgGgch74wdWho5sLYbQOuSlYadOdtVotE4s/oPvgOYW8FVzmXpV7IJtDTxzExu//SIGdYHeg7IEFzGvV/el0udAN78NxYQDEtq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568418; c=relaxed/simple;
	bh=HDTEIEeTth+YlarlZwpbtqNSffqitQLrinmgPBP7yu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpU9UR5tQLrmZYVkDIYMIgrPVW16wxuVgT5stO5clZqdaQXLC/E7GZTXkMQ5iUwHcUFdfdEY/4cuCAlYjqSGrR5vPY62p0j65Q1BZDjyeOjkuze8zTLIzWEt8OELXLGtyArTNFFdcz9m65NpujykAzEi1iaHzhMuEAAQI1MWsRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=HIh9XJsY; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="HIh9XJsY"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6e2c45b81d8so1508650a34.0
        for <linux-hardening@vger.kernel.org>; Mon, 04 Mar 2024 08:06:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709568416; x=1710173216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yn3BxlJjgBPLtIhw8+vZTdHKWgVz7bubHMhhj+7dA28=;
        b=HIh9XJsYBqEMYRZ8eqTP1tlbkwygZg35Z15NyWUUL9pqFI+K7BC8nxqaRJCUP4bTYa
         fJNFOGfr89S6ZL1dr12WqBLdhoRmjg0PRO0L/Z/tc5HgQB0DA59XtGE5yZKpLjA720Ll
         kTNbBKV90lMMKndvzQ1EJU5DFWuP4+mZ+UivCTHTfN2yywKjzrNayUQh/+JfvQeQYHO3
         tdlRTiY6oiycYraN+2Pa97OQEmeseynPpZ6Zk2HfrkQ/Hij0uByIY0JQivFE0eVqJnUo
         geRetPZWlRrrs22mfqNq862Lw3xhLMKRbg4K9Dg/1zkvr3BVU/X37m3NOYBtGT7c5ixA
         GXag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709568416; x=1710173216;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yn3BxlJjgBPLtIhw8+vZTdHKWgVz7bubHMhhj+7dA28=;
        b=moeEFgHAzGSunqD2IsH7WxSWIU8aVi1CEm3EkkpsH8IEx2Gx0cd3wOOO82+RRdCNXu
         6kfAcB8V5BseBjlgYdHOt8ai7ptfl18HYHtPvVuKTptuSUT1B5w/7M4mTKiXYFVeCidW
         B1ZPW1vriJk68zGkJkRcXisIF5np6lPR5NS6+zwvb6J5tNtBk+FswLKA1LoXYjlQ3Y4A
         Jgn3PoMdGqmrZTq/v7OzYsLZ/ozZqm8xJv4BUEnkzaPemWsVDnK8fUCtV9Dvv1vmByje
         mYiFBO4JL7t02egBYyq27ZMe4ibbAb/uJPAe+YOqIOgLxu1/WAs25BlRoMijM0OrdshD
         tzJA==
X-Forwarded-Encrypted: i=1; AJvYcCXDKIwsYVjHsQucdec7Fl/cSxtR/7TplP9cVJWZCUampFuFR2FakgZyHL2zOSdi0fwQe43VV9G8P35eCS57RlniHzNiGmSyTN6xdYJGLKNo
X-Gm-Message-State: AOJu0YxUZODfLpjuzrCN+r7eWdlVuTQqARte7VcZwn6TxIAoqjZkqn0r
	hvKXK25NnDnht8v8JmJi7rVXeB9lRVPcoxlPiyqv5JGIvC1jJxpy+emDolyRrcJsyIXrmSSZ+Ff
	9
X-Google-Smtp-Source: AGHT+IEf31u9H/Myq6t1QuUwWolHTsna+Q0D0Xy9VLu1SozYg1bm/W09fH44eW599tqlHTEORQ0BUQ==
X-Received: by 2002:a05:6870:55d2:b0:220:c434:385b with SMTP id qk18-20020a05687055d200b00220c434385bmr4105937oac.0.1709568415975;
        Mon, 04 Mar 2024 08:06:55 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id lu6-20020a056871314600b00221287ebd03sm83392oac.4.2024.03.04.08.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 08:06:55 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH v2 3/3] spi: axi-spi-engine: use struct_size() macro
Date: Mon,  4 Mar 2024 10:04:25 -0600
Message-ID: <20240304-mainline-axi-spi-engine-small-cleanups-v2-3-5b14ed729a31@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
References: <20240304-mainline-axi-spi-engine-small-cleanups-v2-0-5b14ed729a31@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

This makes use of the struct_size() macro to calculate the size of the
struct axi_spi_engine when allocating it.

Suggested-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index a8f626165f44..7cc219d78551 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -12,6 +12,7 @@
 #include <linux/io.h>
 #include <linux/of.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
@@ -502,15 +503,13 @@ static irqreturn_t spi_engine_irq(int irq, void *devid)
 static int spi_engine_optimize_message(struct spi_message *msg)
 {
 	struct spi_engine_program p_dry, *p;
-	size_t size;
 
 	spi_engine_precompile_message(msg);
 
 	p_dry.length = 0;
 	spi_engine_compile_message(msg, true, &p_dry);
 
-	size = sizeof(*p->instructions) * (p_dry.length + 1);
-	p = kzalloc(sizeof(*p) + size, GFP_KERNEL);
+	p = kzalloc(struct_size(p, instructions, p_dry.length + 1), GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 

-- 
2.43.2


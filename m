Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461973C46C
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324752; cv=none; b=Cuc0rKCdrwrBzdbQzcLnn7Z5QUu3ZTjTbDg2eVXCCb+hPfdixzWASLjD5rJ43ag3IJa1HoY7FuJXcPnnIbjFqjiSDD2n5I1l4YNp1UWm821xnAyL+MKglnoWrn/Fl4OcDosPpl/x7sKBm1gqV5BKHXYTyODoSBJ0c9CHIM9LpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324752; c=relaxed/simple;
	bh=L65CnAU/1fE0bnLVD5fRYtl5Qy3ANgyj2SBr40g08Rs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vo4Whh3eE0Lc61PjU0RxXeph8hjy+x3a8mnPke2qWw4LUMpaofaK3Zhk9uQZReP0XK5teukL1CSBgXk+1E1oGt+tFJyoMXunuGrgeG/d0DS/O4o7iW2qllu0NbImZRTmbKnWujvc+fnSWDrETS0OtUDjhGpBjMu1/NI9/tq5iQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z6OsBG1m; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z6OsBG1m"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e4c6d3636eso772622a34.2
        for <linux-hardening@vger.kernel.org>; Fri, 01 Mar 2024 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709324749; x=1709929549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QBwXoLLpgFu/uPd0sIAAdZiRIZ76bkWotyt1DwrJTTw=;
        b=z6OsBG1mrZqnrXQzZAeduezjnPYdpu15CaGBiB80XXok1/1KH6Nz/svv+uIPIlaeth
         buelwAp4PezVGoGqjO6yL0oe8DK/XmqFwegc4nr3vHJfXOMjvHO9qTiqAu8ccQqB3BP2
         xAkkJEfkBW7oDVU/RPH7tpxsViwNTGXAjbdqBuq0fiCBrsJTWidVF5W66xYpCrzH1exT
         ixzlZlRU6L64vME84PabmI6UhMe9vMDjaSF7iKCSnau+ARFrgP7J81e0sXeH+6NmOc60
         O9VCE97jVk1c3Y5x93y3VVdAGBQhGF89j+OpLXuYIh5u09ebxTY4yaVvN8rcAWs8xpx2
         NOqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324749; x=1709929549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QBwXoLLpgFu/uPd0sIAAdZiRIZ76bkWotyt1DwrJTTw=;
        b=dvim4duS6UVqDEy442FnLdFMRkC4e5U+EBkoNRs43Jk64p2YEbOXPvg5CH91xVw0/U
         2TUGvVH7qu6PeLAmpkMZY3bUMqINwPAflEB5G9aEKHqExMFkvbC4ta7MmDUX0Q089BJb
         wqOowzg6Gy6Gy5XfeNqEFgwOxpfiucCfRoHoB9q4cDpnq6GUEYMPB55bxAyFyR6b3u9H
         cZNTACGX0wUJfqJk2TenVE/J8bB4sqrpM5sycTEoDoLd9WSSmKxDyRIRPx4GZ0VytZyU
         +OIt2lUlFRyMj3MpPdD8YiM25LikFBHW/0FDo9vup+48PPbSq0rPJujlrTA8JefjxJmK
         XDEw==
X-Forwarded-Encrypted: i=1; AJvYcCVnV/N3V5GQ9g2AI4LyCGhRBxjYODC9Mk4PVH3wWwhmf2IAPYNPLXdJcA533mD4opbT+y11PS1BjFkqp9902tQKgyiymV5UBOmiTjodkQyw
X-Gm-Message-State: AOJu0Yz+VZKxA6iqTvnMk3QjpZKnqaBwUT+6dGjSe4UA/PCfLehrRMhr
	e+hYv+jCfkx+7dXWdX9JM1tJ/l5AjF+rkWSk54AuRQehk4/F3GCZNnYYEBGtg00=
X-Google-Smtp-Source: AGHT+IG5IbGrsAHE8Wg0KPwmjwaAmSOb/2Wv78w/MbWbIsnKE0+zK3NiyMKM1IdCCXnj/pV22ljpxg==
X-Received: by 2002:a9d:7e8d:0:b0:6e0:b4ac:8cdd with SMTP id m13-20020a9d7e8d000000b006e0b4ac8cddmr2949588otp.18.1709324749500;
        Fri, 01 Mar 2024 12:25:49 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e454aa54d1sm806213otq.56.2024.03.01.12.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 12:25:49 -0800 (PST)
From: David Lechner <dlechner@baylibre.com>
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-spi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH 1/3] spi: axi-spi-engine: remove p from struct spi_engine_message_state
Date: Fri,  1 Mar 2024 14:25:18 -0600
Message-ID: <20240301-mainline-axi-spi-engine-small-cleanups-v1-1-241dfd2a79f7@baylibre.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
References: <20240301-mainline-axi-spi-engine-small-cleanups-v1-0-241dfd2a79f7@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.4
Content-Transfer-Encoding: 8bit

The program pointer p in struct spi_engine_message_state in the AXI SPI
Engine controller driver was assigned but never read so it can be
removed.

Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index 6177c1a8d56e..d89f75170c9e 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -82,8 +82,6 @@ struct spi_engine_program {
  * struct spi_engine_message_state - SPI engine per-message state
  */
 struct spi_engine_message_state {
-	/** @p: Instructions for executing this message. */
-	struct spi_engine_program *p;
 	/** @cmd_length: Number of elements in cmd_buf array. */
 	unsigned cmd_length;
 	/** @cmd_buf: Array of commands not yet written to CMD FIFO. */
@@ -543,7 +541,6 @@ static int spi_engine_transfer_one_message(struct spi_controller *host,
 
 	/* reinitialize message state for this transfer */
 	memset(st, 0, sizeof(*st));
-	st->p = p;
 	st->cmd_buf = p->instructions;
 	st->cmd_length = p->length;
 	msg->state = st;

-- 
2.43.2


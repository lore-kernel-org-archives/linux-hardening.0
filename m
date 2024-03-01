Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B673C470
	for <linux-hardening@vger.kernel.org>; Fri,  1 Mar 2024 20:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709324753; cv=none; b=cwSM43jbEz/RooMjaleyhHt5Kx3s6PnIZ0UAU1q4fVUDoLUuCHBc9w+cWTfArbq4rmhZz3ekHwOXrRR2pf5e0k4RpDTFPdZxLVOnaJPYpAKr9VAQo+877JOzd6/wLtlJ1ECz4TZJE2dtl4S9y046c4SHLJJtY7V1PQyjyDAstE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709324753; c=relaxed/simple;
	bh=Nwtado1oao3+/dr6Ja7f0D8y63CaM4wWirvmaJDankQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnpbfUlfHJk1Gmbw4PXrZK3AI/kCt8F40RNDbiEMTGYAp4DKir+7AelOxzHs1ynsnXtrbXNVj3Z+g1SgfccpKAtVtQxMeJXsb6jpOWA5vqrMvMiFutPPA0Gc6K0fJdaaRejVsWHYiylfAxoxU+iAEOmpD86JT4ZfOuPjUIWmn64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RDfXWhiN; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RDfXWhiN"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6e47a9f4b70so1358034a34.1
        for <linux-hardening@vger.kernel.org>; Fri, 01 Mar 2024 12:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1709324750; x=1709929550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N53sN/U1+xpmw3mnYyTxppc9z7x+jOYBw1SYOpnydHk=;
        b=RDfXWhiNKyfc+QRNMmfesLFDocNny9FbkTUtO7mNG3PQ1YF5IqSYMN56pwe0J7s3l7
         Zp2zf3QEmYmM/T6IgzuPuB3fc9aVrWj7bUCZPyh2Uamq0BbeE45kHSoMZF2TE5DMer59
         AFXoJ3TeDcQNlLrjbc+ZOa96RxX4fNC28ZFCm73hUp9E6lUz0AcMQV+K6+OeU+MOeVlv
         JZn12Byl4ovcBf/+opEoqWdUw6w9y8SVOJxoj2vnTJi39ip/cuGAKoxaBlOckXVnKyhl
         RWVNR/9NN8nomqrMpg4ZKYXcMn4fik1B2ggHCi/jTkidN8EHH519sx4AcAGeYf0X6yIS
         b7Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709324750; x=1709929550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N53sN/U1+xpmw3mnYyTxppc9z7x+jOYBw1SYOpnydHk=;
        b=feTCS8Sz0z0UYaHBy43I8hNLhAx4kjZpIdsYqAVhzmqpj/XTHYtDmwW3eWlifYJfwm
         ri80gMOAqBo+h7a5RdLOEA7a7nN5DHNMizZ+RHKyCCW921a1Xri3px1RpdkY6/Rji0af
         4a9vuA4Q0xWgMroOtGHTHl3UO2eiV6USRhm2y35xafUsr1quXKE1riWfT++srSjaNzfb
         H9ymZtWvxXIQFOzx5C/wcJpTr1Jxe87x3k3OtoldFRrJvpAIu5EJps3TH/OKgs9LkI1V
         eg/NwcDwLdUZppGMCWnFPYs96qpJ02LDMsmwOcKdL6sTQu07cYAGMA1JgWAw8xAeJ7oM
         qzXQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcnTXdnOES5IPhXA2ny3tIusnuiGAJd4eiZrbaYjv7msa5Plo65L4xf8CJVOMLROah6yG8Qrs66JVUUoLpM/HjbetrX/nMpkIpGtXrVVl6
X-Gm-Message-State: AOJu0YzOI6FPWaMi63Iw8/ZbKHgCEycVZ156PN57UVQ5+Qb8KEIm26Td
	0ujyOHyJeAQelr/53YcQjfIEbP1eGu1wu+hnt6nc7lGbJAUH3Wq/GkUCSC6X10k=
X-Google-Smtp-Source: AGHT+IGk9Oam5NAqD4qbTMwFeQNceja2+ofM48cakPFOdGJ3lIgV2fOupeQb0XQ09SKibb1/IWoN/w==
X-Received: by 2002:a05:6830:39da:b0:6e4:d195:ce91 with SMTP id bt26-20020a05683039da00b006e4d195ce91mr1043577otb.19.1709324750356;
        Fri, 01 Mar 2024 12:25:50 -0800 (PST)
Received: from freyr.lechnology.com (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id f10-20020a9d6c0a000000b006e454aa54d1sm806213otq.56.2024.03.01.12.25.49
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
Subject: [PATCH 2/3] spi: axi-spi-engine: use __counted_by() attribute
Date: Fri,  1 Mar 2024 14:25:19 -0600
Message-ID: <20240301-mainline-axi-spi-engine-small-cleanups-v1-2-241dfd2a79f7@baylibre.com>
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

This adds the __counted_by() attribute to the flex array at the end of
struct spi_engine_program in the AXI SPI Engine controller driver.

Suggested-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: David Lechner <dlechner@baylibre.com>
---
 drivers/spi/spi-axi-spi-engine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/spi/spi-axi-spi-engine.c b/drivers/spi/spi-axi-spi-engine.c
index d89f75170c9e..e801eed820df 100644
--- a/drivers/spi/spi-axi-spi-engine.c
+++ b/drivers/spi/spi-axi-spi-engine.c
@@ -75,7 +75,7 @@
 
 struct spi_engine_program {
 	unsigned int length;
-	uint16_t instructions[];
+	uint16_t instructions[] __counted_by(length);
 };
 
 /**

-- 
2.43.2


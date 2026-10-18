Received: from out-2z4y-a139.jellyfish.systems (out-2z4y-a139.jellyfish.systems [198.54.127.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA214413797
	for <linux-hardening@vger.kernel.org>; Sun, 18 Oct 2026 19:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.54.127.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792352932; cv=none; b=Zda4lvNwMzxyUorkgnsQmR47W7l8wT2hgFg4leYggnu9YWfwJ2QCuJJfDrBH7RwdKp9IK4vSgluabfBlwzFVqnTAI7GIBx0SPPZWXO8GpFwytSqyGC6uLGLu9sSGBBI2FDca1VOyNaezVi7eDZTXRM8BIhAMryDTXGcSsvagoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792352932; c=relaxed/simple;
	bh=boGOzc+0R9GijHkcuHUBW222YFutKUnDB9YqKc5jI1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RLK5pI0fOo+BJbTkNiW6XeRGJEuMVSWfc+HgCkDmN7Lp9P3zFtvho72bCRkJWd2v2MpmdKGpUAv9wZ+WXBoW3wg88KruaHqThjl0hhANwZmV8jUP0+GBSH4zh/CkjTFZohc8jGHreovKiYMB83n4m7s4LWMueXzDDkDOi8nn9ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca; spf=pass smtp.mailfrom=r-sc.ca; dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b=j8VGuLCt; arc=none smtp.client-ip=198.54.127.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b="j8VGuLCt"
Received: from DESKTOP-290OH2S (d207-6-150-133.bchsia.telus.net [207.6.150.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4j78HF05VLz8sWQ;
	Sun, 18 Oct 2026 19:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-sc.ca;
	s=spacemail; t=1792352601;
	bh=yRcmqQQ5lQFbIOpFg3KW+TKnDp2sOvrAL/khscqtu3c=;
	h=From:To:Cc:Subject:Date:From;
	b=j8VGuLCtrpGSX8lotJksOWvf2xn8UGw0CZqL9VLQE1ksuPhCIeoYFMMQOYR+L/OPh
	 vwF/Qs8+ev1oiad3dX8Qlv+zWsl7+IQ+vGiNH0XxspseDKE+u6rAIoKiD6BtUoLME9
	 +iBvEekSjuS7KvrCBlvCcePFuTG8Z0xNuR/NfjGOEQDY56uqK2AaB5cn0AO2yLLPJm
	 OTZUhjBQ8xmQ6KhYIqiNRA1tRFp5K5x/76U6CTYLxQsaLAqxxul2sL4ZVQ+OaIv1Td
	 O2fEVn6rVREZ8zzP/2Q8BkBsWe8Do6SGLt1/iQxCwl9tC8CyIxKxOwF6vnttaOXBSu
	 4/Y3ELOoqEVxg==
From: Ross Cawston <ross@r-sc.ca>
To: andi.shyti@kernel.org
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kees@kernel.org,
	gustavoars@kernel.org,
	linux-i2c@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ross Cawston <ross@r-sc.ca>
Subject: [PATCH 0/2] i2c: add GPIO buses sharing one SCL line
Date: Sun, 18 Oct 2026 12:43:13 -0700
Message-ID: <20261018194315.945-1-ross@r-sc.ca>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: ross@r-sc.ca

Some Realtek RTL930x switches bit-bang several I2C buses on SoC GPIOs
with a single SCL line and one SDA line per bus. The MokerLink
POE-10G07110GSM, for example, has its fan controller, its PoE
controllers and its SFP+ cage on SDA GPIOs 9, 10 and 11, all clocked
by GPIO 8. i2c-gpio cannot describe this: every bus would request the
same SCL GPIO.

This series adds a binding and a small driver that requests SCL once
and registers one i2c-algo-bit adapter per SDA line, serializing the
transfers so that only one bus clocks SCL at a time.

The SoC's own I2C master (i2c-rtl9300) is wired to the same pins, but
it moves at most 16 bytes per transfer, and the PoE controllers on this
board only accept their 25 KiB firmware as one continuous write: sent
in 16-byte writes, they NAK the second one. Tested on the MokerLink
POE-10G07110GSM.

Ross Cawston (2):
  dt-bindings: i2c: add GPIO buses sharing one SCL line
  i2c: add driver for GPIO buses sharing one SCL line

 .../bindings/i2c/i2c-gpio-shared-scl.yaml     |  94 +++++++
 MAINTAINERS                                   |   7 +
 drivers/i2c/busses/Kconfig                    |  12 +
 drivers/i2c/busses/Makefile                   |   1 +
 drivers/i2c/busses/i2c-gpio-shared-scl.c      | 229 ++++++++++++++++++
 5 files changed, 343 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-gpio-shared-scl.yaml
 create mode 100644 drivers/i2c/busses/i2c-gpio-shared-scl.c

-- 
2.55.0.windows.5


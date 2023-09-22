Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8304B4446B
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 17:53:00 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA6CF19AF
	for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:44 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-690f7bf73ddso2160951b3a.2
        for <linux-hardening@vger.kernel.org>; Fri, 22 Sep 2023 10:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405164; x=1696009964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AKcTEUj8iWRNEK5rhXHlvqlvJUWDGLncQV9/wNZHpmU=;
        b=DYg5cae/duB9AitzfuLwoe1UnHAj3ozP5sBVryq1BaipFeo4PzmKf62Omdj30V88bW
         g3ntRSeU8856wtgkqGKqu/L7dUwP6w9eUlkIBBQeXz9E85ChgNaZGDwYhIGaqPt52sUL
         F+f5XLvrAgo713NJoJOJB40zOQEzfLkE3tAqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405164; x=1696009964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AKcTEUj8iWRNEK5rhXHlvqlvJUWDGLncQV9/wNZHpmU=;
        b=IRj/eF3ZyAKBg7+cUWtdCMpEBUc/8aRbWLxZ+Tg7Tt+FOY+JEQWgg0YlVVAirx6lrV
         jK46FWPdaZDABs662zSM5Extk1D8N3Ep8fLtiCw6/ziUL9/5KseOrm3YejwnqCvei/ao
         HJKWX1h3gnVFyWVqFRWYmngTKjGwmHaRcFGC1ya1nfOt61STBTUy1QG7X6NN7brp4PkA
         6ZbRgYszwruKJA2io45up/SgL5lHlKrF5Msim15klinl/CTl2Hsss+hrpUgYqONg2cyw
         8BUHAd3yswZ0c78oBgAKohxHkfj7/japDW1Fdk3KhYxY6g8jLVFM0+5xGjvo7FSwg4KS
         RUpA==
X-Gm-Message-State: AOJu0YxiRlvfc4TYqdF40N/77MviSUSCklhmtnoHXZpAvM39h5ldk1y9
	iRCVh/QKitN6LCpVBrWkCMwRDA==
X-Google-Smtp-Source: AGHT+IFcZ2nzBI3A0UTRKqOac4LH9HvLFHz8MxYKDbtUI0JD2i5Xbz4WZj/Ts8o6uPZBgffxVIc8zA==
X-Received: by 2002:a05:6a00:b48:b0:690:c5cf:91f5 with SMTP id p8-20020a056a000b4800b00690c5cf91f5mr117787pfo.18.1695405164132;
        Fri, 22 Sep 2023 10:52:44 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w3-20020aa78583000000b0068fc48fcaa8sm3478519pfn.155.2023.09.22.10.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:43 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc: Kees Cook <keescook@chromium.org>,
	Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	linux-serial@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Tom Rix <trix@redhat.com>,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH] serial: 8250_pci1xxxx: Annotate struct pci1xxxx_8250 with __counted_by
Date: Fri, 22 Sep 2023 10:52:42 -0700
Message-Id: <20230922175242.work.442-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1395; i=keescook@chromium.org;
 h=from:subject:message-id; bh=jptRej6n4r8+QfuX8ELfIL7gLpWh8NzSvtTLQlj3Cis=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRqDUgpGkAhEUCeWeGjwYBLAvWqMcZQVrKX7
 /m/cDSHO2uJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UagAKCRCJcvTf3G3A
 JgPwD/wOJwcIR2GmMgDcCm890AqV8kE/hY5vtXEGFf0gRO7JOOlrDWRrHsX3h8F3c17KPAsrIk7
 EyCzeVTgoVgGMYNmwA3nqJBtSz8ueJTFy/MNhLfvQJ3aeDHONah9OwBYUG8Fzy9LsQwe4hqCmzA
 GkSs3nTFSjZjs7K+d7vNRbHZuN+8Ifwjr+mlK2pyqTpruWMQD+OYNdsCH+/cwRSZia+1O+POSpp
 GAG2jWADROCEQ7lVuLTbzhfH/dAta1Pf4M6ofuNcc12xICj9SVjHUxxNuueCeWuH1978GiyqxHu
 UmX/yu3PnghaIELLR/uwWN5DukiwoJJKk+wCRBK+rDonOSU9SlS8RW14dsTyZpov1B5TOzj+5FY
 euJ8NFGaA+6E4PnxbO35EJrkJVToLzkBPh3fFa4beFYkiglkSuz6R3btkJzGjhReBIFfty1HE8x
 hByFM/+Ko7whIR+pO95KPDv9H8+ksJ8wPVJR/i7AcCMCDHZAbOdSbHIIerZx/IRacRayFZG9Cf0
 ddzxp2hMAQBlpopI5yQRhJEUWqgYBGBqIJ+IlMzRjvgNDh4MwPHE6RNbhhuW6f6XJlcDw8NGLKa
 vXdG8ciYRYOLfNbgunMdNeUPs/3joxwXKw0TanH4JtEsqxUDTqIzb8yn5U1Cb7ZRoLUHdOK6pJP
 pvSEvfa JuPKFMyg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct pci1xxxx_8250.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
Cc: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/serial/8250/8250_pci1xxxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_pci1xxxx.c b/drivers/tty/serial/8250/8250_pci1xxxx.c
index a3b25779d921..0da9847f3e91 100644
--- a/drivers/tty/serial/8250/8250_pci1xxxx.c
+++ b/drivers/tty/serial/8250/8250_pci1xxxx.c
@@ -107,7 +107,7 @@ static const int logical_to_physical_port_idx[][MAX_PORTS] = {
 struct pci1xxxx_8250 {
 	unsigned int nr;
 	void __iomem *membase;
-	int line[];
+	int line[] __counted_by(nr);
 };
 
 static int pci1xxxx_get_num_ports(struct pci_dev *dev)
-- 
2.34.1


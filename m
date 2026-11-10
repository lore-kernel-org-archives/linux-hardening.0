Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794285170;
	b=rvyFG48ejOguxPbaKovqjgjqCvEGnue1+3n7HDuQS/Nay8FApittCHX7B1burqgAosft
	 wwH17GtmgMFApJ4XQ+6dzJG8/iVgluluqqgmO+Nstq9gwa638ssp1pA8KX2sGXa9bswQT
	 /UPi2eqWPTEY6TnzbSkSGzMNeajL1z2BTwUfAjtyKf+WTU8hbA/liacnhy18aujMCEkvd
	 8YUTRA7hSCZ/x1/uXMrJtZYoaCcddjj1sdkSelcJ9cGQzslv9X+LMB7WuaCYbPmfRGq6F
	 rg4znt8418sIbA4H992z89Pf730VNYZb7g0yTFW4GzqnyMOOutZzNJwKvIhEEMU71DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794285170;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=o4jQDhcjo31dbJg2wJaIjLSidLekK7fUkFsWw7PV7Tw=;
	b=SKvBSnTI59MdjtXqbvhTouzn7FuhOI0lPNRMoFeggwH5AtQSuBj4PxOwmAit+nJdbbQt
	 EntbBLC1y7G0kaZF24xfXCm1eItUY9HPCQax+su7c10fbJ5CbvX21M1pMIaL7+H2ua6aj
	 7+o40yymK5Av3BKrzlSWs3SMvXbEAqf4NBrk1ek5/bWswoxVfUlqv/TOirAa+Ng5LMEsI
	 Ri3+GTaQQca8IoDRggqX9ZH/+0KNzV9xl+8CpkGW0QWKvKCAz0lrG5GjVp+D/onTluHiq
	 iOuvPecCpuS6Vo0Y4TlTlrYt2ox4BIFpV3J3pjDPBwn9rEs3ATZyYppurOoP0vFvk1g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPbvEt3r;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2987C606A33E;
	Tue, 10 Nov 2026 04:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DPbvEt3r
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794285169;
	b=SIJMwSUfWPU90zWjzy2SgMlTifAdkVYIcx/qq6hZ4ZOE1xmUHY3se4RRT+l6z4e8rpdJ
	 6oLWWDgQMf0XYxhTaIu8NuFTm1COcbYy5XMSCyBfdQAd/6+XzHlQLF4nksUGiFSwrtbwq
	 1Jz7N73gfbw4nQC1TrUl0vWaOokkERIl3c++d9/p7sUJuU4CtWLyIFse2Q5ZCvlsHdAoP
	 lx4J1HYdkavGeZUHptCb/6VAz+gqcsO1BreTJJnIjh2DPfi2gp24zMF3hhBH/X6gWq52A
	 GhiJCVzkWiByeQM0viruQVaT8sFPUR/G9hWhSy0pSRYq+g6UJL8Zqid5hJzUbdNUe1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794285169;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=o4jQDhcjo31dbJg2wJaIjLSidLekK7fUkFsWw7PV7Tw=;
	b=jDFm+N5xfF4xtvP1FS7xSWFfqRu0+Seet1qh73LFsH5lP5c5a4NufQILmZsy8+RZQqXk
	 hWT1sPBIuqqfIGiFBbgkTeBrlzXNO2uBWpJLPthkdvA1vBHZ5Sq1Z73UfJ5T7szuHGv7O
	 DJU15lqOPZ6VCHHjWUyxjJsQq+mcy36e4ooOV9JOwt9XM5ND+cVXRG0+UuEn620XQ1CBx
	 LkvZ2MgOTBaj2mFMJC2ZYjii/alpyiwfYP85dcme8nVThvKmc70vfvg1JuyIJIwazzCzz
	 xQPnG1YrX7wrHJaCzqYKWMd8Uj5e41jq8q9yXHxTprUsomK6q1fcrmdO6DopS1orWeg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B3ECD1F00901;
	Tue, 10 Nov 2026 04:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794285169;
	bh=o4jQDhcjo31dbJg2wJaIjLSidLekK7fUkFsWw7PV7Tw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=DPbvEt3r6SkdUBG1NW/AhoWx02cO1N2RVtYsjxCjbq2JtAHvIdb7+F8V/8Qab8w5T
	 7ypvLOe7AOdKdCRqddRyCODxAoayZhhkZxz3dGzRXx3bQI97r+9ExZy5Is/KBbUT5K
	 90yRpk377j4JwATVwW2jG8JRzpItK62PhV8D/F8ie3TS2kmrTU0NKrWKTI/QJYh+9K
	 mjfib8TUfviM/06uPhSqYRdxClAxSY3agv0UcPnRUkOtjGjWuvDi3l+ALejWpTkiPb
	 aPUBc/DZb1Wrulur3ChNUK0rCX9g0jGdN6QWqk1S0twwk9uPdRYwqAgXqLsRZxhw4P
	 Mf8i4K6XKUoEA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 70BDC48881;
	Tue, 10 Nov 2026 04:32:45 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Tue, 10 Nov 2026 12:32:38 +0800
Subject: [PATCH v14 13/14] lib/string_choices: add str_rising_falling()
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261110-cv75-gpio-v14-13-e586aad0467a@ambarella.com>
References: <20261110-cv75-gpio-v14-0-e586aad0467a@ambarella.com>
In-Reply-To: <20261110-cv75-gpio-v14-0-e586aad0467a@ambarella.com>
To: Bartosz Golaszewski <brgl@kernel.org>, linux-gpio@vger.kernel.org
Cc: Linus Walleij <linusw@kernel.org>, Michael Walle <mwalle@kernel.org>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Conor Dooley <conor+dt@kernel.org>, Mika Westerberg <westeri@kernel.org>, 
 devicetree@vger.kernel.org, Long Zhao <longzhao@ambarella.com>, 
 Long Zhao <zl020895@163.com>, linux-kernel@vger.kernel.org, 
 Kees Cook <kees@kernel.org>, linux-hardening@vger.kernel.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794285162; l=959;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=wyB82tzUGO+6Su8wsiZ1PCnlZE8C1WY1st0J3Yh3blM=;
 b=ujWayqqQBdxFq5SKSKgXak3dYThVTLR5XGPpoFdHd0TQW3ngeSzAXibkTrG+AXd0Oyf2AbZT7
 yuiDKQz51EzB/SZO0I77rOUkeopsiattzaFAsIuzsW1XVFy6UYFfjmL
X-Developer-Key: i=longzhao@ambarella.com; a=ed25519;
 pk=/xGhPTOX0/eYsyTWzyjjgAIW1Z/YD+IlnOnvcdRozow=
X-Endpoint-Received: by B4 Relay for longzhao@ambarella.com/20260730 with
 auth_id=903
X-Original-From: Long Zhao <longzhao@ambarella.com>
Reply-To: longzhao@ambarella.com
Content-Transfer-Encoding: 7bit

From: Long Zhao <longzhao@ambarella.com>

Add str_rising_falling() and str_falling_rising() for code that
prints an IRQ trigger edge.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Long Zhao <longzhao@ambarella.com>

---
Cc: Kees Cook <kees@kernel.org>
Cc: linux-hardening@vger.kernel.org
---
 include/linux/string_choices.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/string_choices.h b/include/linux/string_choices.h
index ee84087d4b26..c3a0360334d6 100644
--- a/include/linux/string_choices.h
+++ b/include/linux/string_choices.h
@@ -65,6 +65,12 @@ static inline const char *str_read_write(bool v)
 }
 #define str_write_read(v)		str_read_write(!(v))
 
+static inline const char *str_rising_falling(bool v)
+{
+	return v ? "rising" : "falling";
+}
+#define str_falling_rising(v)		str_rising_falling(!(v))
+
 static inline const char *str_true_false(bool v)
 {
 	return v ? "true" : "false";

-- 
2.34.1



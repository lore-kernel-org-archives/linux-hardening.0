Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794987759;
	b=mTSKEcyBOGyN7H/jgg/L5GAi2RfTrgaAGO3NJTCvJmLDwzDxkyiQT2ohLnisNf29lnmF
	 ZJDItkenxg7s/+q1iuRya+KApb1PUxIjgzvRYu1gr+AiSeKUgZsBGZL1ea9S7FtZhEHdg
	 0Le0PDh40Nf6UDGDp4D99+3O2XuDT5azNg8ys+ZbjlPBW1pf2siFTw/kBM60zCEocd/Gr
	 JT47IKhPH8z26+NKltU7zml5ZP8hIYUadZmaQOre8BH97SafShYoZovY6fN7543W8CmWT
	 ioauziu4NJIkyUTuadLkAG3JYZUypr3dRdvio1m7NoG10uNpBQtKxnzh5AVHLVCuUlQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987759;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qKjvfFs5BsHnQMfZ8QnjGxYBAgWvz/r6FHDrTysrAx8=;
	b=oK6evMfWZ7KhDxtEz+fh+uGqlyVfGQcb1jwaVsJtQ5UWNddZGv/FKp2xZwYi5Fg7NFsS
	 Vaz6+nOBJ6kyXabVAxxSQZgtjfOdsIXLp5z6KGn+jtCNeBCqAA5i41QHNAhrQCWsaI+EC
	 npHRYOX/O+VkXQyDd98+ycnrkS6Mk41yFFb6dFNPVZe7Y6cMKkzwEP6XSGMXlaZdkqvN+
	 b7e6oeD37CvGfURcahZidzFH/YqybvKwOjzDZEVvAQZb6d/ytldwRK+TFeLYZECKzyxEq
	 pVQPUpj6eH16axAncmx/1tW/wpI/ndvWO9fQPnxtzPNT2q8kMY0G8EWuqvzhXuQKNbQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PleKzVFv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B02960A262A;
	Wed, 18 Nov 2026 07:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PleKzVFv
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794987759;
	b=LvyOAjxgdLm56Y8pgKIXDVmxyroGEItrk+Fz4jgdPoVWBBzCIC/tmNuPSZ1avoGVC+fh
	 He62JpM1SHL1zU87axn94ftJ4atQPPNkGhMme8JbIcL54G8Cz4qvVm1r3fdlXPyCGAD/m
	 nY4fj+HT6P4qv31ogQdufNZIN6anLpaMQmljx0fpfCAGhWMl1Ro05JCTL38Sn4zxPG9Jl
	 a+WjFMxR+/xUHzXkinoPueh1joqsJpexQx0qZfvqq60GyjyQatj0J+koVmMhWb6ND/Egu
	 0sC8XpKcQ+kDq8mCOUPUMUqP6RqXMqkmliiEjMxi2yB9UlKb9zRcp2U5O1Jfn2zfe7w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794987759;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qKjvfFs5BsHnQMfZ8QnjGxYBAgWvz/r6FHDrTysrAx8=;
	b=0lGD63boxz08SwYLVF59XMezXRRAD8wy9wBPnI8yp+lwmIiVTEs00GpHD6d0la92hn9l
	 I0W22Te7/eYc43apu3EEkfr6+7NpHrB6NcZCJtJCzrZQmaB2Q5FuXOac131UBAxvPUawH
	 Lb7/rWjisBu0qerVwAiu70rze9GSejTYj0j+ZcUUp9XMjTyYW0lzMn0Fl1cy3aTKSSXOQ
	 Whz5gsHaceljlUC5lkxgd/deOcXn1W5Ii+4anix4QiCaH5BcQFQblh/qWSZCeUJFtmTf+
	 +K6UKjC+LkItznqRzRWbTmO9QYD+RijSRsNGopoH4Kz3gWmDK6aPjSkjLawfY15GIJA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9C1141F00935;
	Wed, 18 Nov 2026 07:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794987759;
	bh=qKjvfFs5BsHnQMfZ8QnjGxYBAgWvz/r6FHDrTysrAx8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PleKzVFvxJvAEVGMY4qUwstCtL3VJwSXUI0h6D9d0yad5374UDyLGhE6srYNjxnMe
	 2VAdEPgNYak6Qv26ToHpGUCkNdWO/9Zzr/Uvr+SXsSPAhYoJmphqW7rRxXS+tssbP0
	 zw0I8O65QhAULZr6oglvkGRgnfY/YTlHwAbA3f+/2Qlz4c2zZArHCC1KEXlGZX6zUw
	 HCJ63lUQHf0yEiBOwEA9yEOeZGD9B/2il+UzqkZZZ1STzVx0gRk0Gf/26qqvhNoI7S
	 MQQ8sWeEafgB8CmkYPSIirCA8gE/v85blZPljdYR2eGRjxT5tA5q5cbmPFsjIxin2F
	 O5Pwe6FIk2xyg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AAD4E4AC86;
	Wed, 18 Nov 2026 07:42:35 +0000 (UTC)
From: Long Zhao via B4 Relay <devnull+longzhao.ambarella.com@kernel.org>
Date: Wed, 18 Nov 2026 15:42:30 +0800
Subject: [PATCH v15 13/14] lib/string_choices: add str_rising_falling()
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
Message-Id: <20261118-cv75-gpio-v15-13-e3c563673fe1@ambarella.com>
References: <20261118-cv75-gpio-v15-0-e3c563673fe1@ambarella.com>
In-Reply-To: <20261118-cv75-gpio-v15-0-e3c563673fe1@ambarella.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794987752; l=1025;
 i=longzhao@ambarella.com; s=20260730; h=from:subject:message-id;
 bh=FF3SwrOkpW0JCkZHC45tCcl9+Au9JLZXuWRMnORl0uE=;
 b=GZalHhTrmgy4FqDEQif7Q/vUs4w0TqWNnfrRqb5DJjgV3l73WEVpMpyj2216NN1wkNflzvCsU
 aiI+PMOCZkgAKA1nzKxHAdj3H3XvZwQH1z2WnVdUDGHdpsPEeYcHd38
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
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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



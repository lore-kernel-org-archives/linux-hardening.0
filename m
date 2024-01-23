Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D143159597
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969748; cv=none; b=ogLelJo76uMimyfXwPdz6eo5izOT11KhRqlJZLvlCV86OkhkGrkpIrjAcyILQo+JziK1pmY7yWYliPQ1nX7zWeALYWSRq2XbjdUO4NSzSg/ZTHeSQLioVdrS33vcU0rHcfbUs8LSnhnxzCgg1XYMCU+ShF8+WfeAf6CwYdXJPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969748; c=relaxed/simple;
	bh=e7A6lhz1YTrc42RiVqJvDHkNtpFxlmtLyS2WOTvLsQ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pZJFBTuwTZnQCnzAOWT6RLUbkJqskNzc3c5ueugY1bSLHuirDE7GDcwKnGRx1W/BZEvcDN3C/JlFkQSyBHYvY5pXoQh9uopdva2ZFVYwjmj9vcM0CZR83XtXNzjq33GRMzwTXd0+5emLsvsjlA4iGAIokemo1sS6ibMR6f/73gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BNfM3xs+; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BNfM3xs+"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1d41bb4da91so19667565ad.0
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969744; x=1706574544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2VCA4MiUm4hxtqb/2/ihwHQ4ffY15Cbnf0o55fNjhH8=;
        b=BNfM3xs+1yPOeKCdNABC7X502Zx3m74aSHmWYKpm3ntrrpPT4KTb9LShxaMCkOcBTZ
         jmP22vkgP4+b07DIGsPuBbyc7f04j2J1mo86pltd4yljNThSlMQVeTfiW7uwVm/iEHt0
         iN8mbVXnOJzqfqBVXlG5SFAi4/p2eW1zCYS1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969744; x=1706574544;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2VCA4MiUm4hxtqb/2/ihwHQ4ffY15Cbnf0o55fNjhH8=;
        b=IzLkigf2gJurHdT2+rxc41IcTww5ZTBBaD3X1/Fhy36fTs0SdOAbu7JlsDzEecXpS3
         4bzONawIk5ObgQAwLM9E+U65kinWw3WOhaUuUNqsBfYndwxkp9ahLXx/6gEldD6NAQvW
         1e3IDa1zujJEeOclw03x1gF8cVMheESIKT9VpqPqnkX1H8MgSwg/eWN4gVaZU3t3Fwqu
         sZ5KB2FErwOujRfbww9/KkJ3rqjUVNddWiyFoGPoUP2PRRTTOvk4HZW2Gk0jGiswSPVA
         0zTY9o8u9tUCxov7xm4XSMRl7q++HUANbouXD37Z6Mg/dndGfQWpm2UvBtk1xY80/Rpy
         HSLg==
X-Gm-Message-State: AOJu0Yz8C7x8zfHWzCBt6IjD1cZ9Q5Nz7ubVRo9AmnRh3RJ1QvhLHYUz
	B+0dH92kr694THFO/X2B4nbAzHd6e+0kZwoQxB+POivO314TVsqTDvMlJyhH8g==
X-Google-Smtp-Source: AGHT+IHkoc29tLvtCHNJqiIhDN5o0+Ip7IYWQLpp6GJH3AJ1YZPTOMPreFRrlPzqUZzxKRAp47Hy2Q==
X-Received: by 2002:a17:903:22c4:b0:1d7:601f:a093 with SMTP id y4-20020a17090322c400b001d7601fa093mr1304472plg.96.1705969744416;
        Mon, 22 Jan 2024 16:29:04 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902d05100b001d5e34b3285sm7806408pll.16.2024.01.22.16.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:28:52 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Max Chen <mxchen@codeaurora.org>,
	Yang Shen <shenyang39@huawei.com>,
	linux-wireless@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 41/82] wil6210: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:16 -0800
Message-Id: <20240123002814.1396804-41-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2027; i=keescook@chromium.org;
 h=from:subject; bh=e7A6lhz1YTrc42RiVqJvDHkNtpFxlmtLyS2WOTvLsQ0=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgIQmyCTrW1bahod8KxHdvoHy58y6yL+ETvY
 BiEiuMJbS6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICAAKCRCJcvTf3G3A
 JiRmD/9zhsD2mE1miG7SGjJBAYcdyMqu0B11enBzCr3b8d5xqV58q4aN1ZngsnmNjttQaMFFr1T
 9Gh/s9u56ltYlqudIxPMUSZSrUHU2C35m4gtJ4TVkt8qtfF3folCHfMmbV4i9KMdE1IgEESn2G3
 ogHxJ2XbUbwxx78z6StXZHHDfv5VPBwzr9kupbCeVGteX2t9bmMldyxqif+YKl45puapBWNQ8Ib
 cMeONqZ1xuDyp0U/qIu9iXWQJJuzn/IvIutdDznavIBE1ZLOPgsHof0dVXEQjpsQ5oSNU05iKIy
 RCwhvKkR8cxQTqAQX5If0192u8p1TEX99NSo9gLaza1jNIdOd3aMy1J1x2Opk8hxzJLbpIOuzj1
 CTLFFWDkPJHVyQi+TjyQoxZYjoi4jpnAv3piOF3Qyc/Ftx+LToOJ5NZQIgUKQCEtNf33XjtQa6a
 UhBSAs1HZAXgKJZmFa+Pj8Pa78PFbLKWQSpTG4JE6qcecARMPZCyokWGe0WhhJzVf/hUAC2ogd8
 RJhNW+Yolg1sqIWb4Ywf08WqhPZzOgqnSxV7Wm1OaMy0cDOWgX/20YYlkZJXEe3jj840ChWrQDt
 6bAIZMUBgi1USCdj4y617A+WtpZFjXDgWs9Q7XoNPEbOQ9ovO/3v9cThNhMGw/rkG372enD2SYp VY+mP6vYO8kr7tw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Kalle Valo <kvalo@kernel.org>
Cc: Johannes Berg <johannes.berg@intel.com>
Cc: Max Chen <mxchen@codeaurora.org>
Cc: Yang Shen <shenyang39@huawei.com>
Cc: linux-wireless@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/wireless/ath/wil6210/wmi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wil6210/wmi.c b/drivers/net/wireless/ath/wil6210/wmi.c
index 6fdb77d4c59e..3b3c991f77e9 100644
--- a/drivers/net/wireless/ath/wil6210/wmi.c
+++ b/drivers/net/wireless/ath/wil6210/wmi.c
@@ -286,7 +286,7 @@ void __iomem *wmi_buffer_block(struct wil6210_priv *wil, __le32 ptr_, u32 size)
 	off = HOSTADDR(ptr);
 	if (off > wil->bar_size - 4)
 		return NULL;
-	if (size && ((off + size > wil->bar_size) || (off + size < off)))
+	if (size && ((off + size > wil->bar_size) || (add_would_overflow(off, size))))
 		return NULL;
 
 	return wil->csr + off;
-- 
2.34.1


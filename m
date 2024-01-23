Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ED05DF28
	for <linux-hardening@vger.kernel.org>; Tue, 23 Jan 2024 00:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970162; cv=none; b=tlAlR9O25E6/uGp/WsLVhM6twTp9LOErBpTXZ9G0QnQLKMKqRvwp4R0LVQUg/49ovJSDipSAMllfXzOJGHs48gw7vE6qLesS8P02VliHQQFjWGIsJ+Ybj7tNZP2d7OcCFb7ku490nNONTkMxb4MzVNW3RMgP40fEpnIhcdgv1HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970162; c=relaxed/simple;
	bh=nGybLOIsuTz/Gb9B1iN3NLpbKPO1DsQM9K1PTfrNPdM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AeF46ZQbuNaXMstqqXAKrAC+VEbHAJGvJR4c4NILmdObripHSKbLCaj5vxKAiicLo8zGvb7nND9K1VftB2NIcPOqEkLVdwFgX585yaV2lBYOW7lRyO07bGfwDqwqfPYFbgeW5MPIC6Pm315n+y6qmMCtwylzKW3A8r3suqPXsmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XUanmnYs; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XUanmnYs"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5cdf76cde78so1851935a12.1
        for <linux-hardening@vger.kernel.org>; Mon, 22 Jan 2024 16:36:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970161; x=1706574961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDa9oNn6F2ovUjbcqpVWupPtvSG3Yc95imKuqvbvgJs=;
        b=XUanmnYsPUxr2gTvzGVYaMzZL9E9AcU3GUA52Gz9cz66xR/dpNoDbA4kCJpY5GEAzb
         WU6dTn0ZwSxqqCNHu3v4br4nJPLpNwvukbM8xY3FM08wejMl/RHBgp1CmId2JPM0hivM
         5eA84oUg2lG083FsEyz7ga8BhzqiSjFEi1L1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970161; x=1706574961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDa9oNn6F2ovUjbcqpVWupPtvSG3Yc95imKuqvbvgJs=;
        b=b8WOelbsRd194hjTsb0XDluE7TnItc7ms5wOM+7URH7EAyvmV7wvvnz/c0tobJJveP
         aIG11Bt2yItPT0l4Jkx54td0G0xIqTW/pHo4g8wDiNgPT4OC0+IGZl/LtwWDbQpGm1BF
         jVMczwS+BrHm/EJa8sZKroHD3NdiAtfRoK/IB7Dxwl2diKFn/IppYoa85EwB17hFKx/o
         i2oMUvc/uH/edheSPMsGzDVGpJrFdavQ68lGx3No/UY8cMM04RMF53PTvwzHGHtOijwr
         wH09UViUuPVCgBP+tcAdPYr0k91ta92mFEksec1/TxStgrQIbMedKHgpwPXk2KmnsZph
         sfdw==
X-Gm-Message-State: AOJu0YyCCR744so9C9L1ggXTwVwHXF8kgZ+EMMaNmQIBCxK8lw3+ebWG
	LPjgA28aP3rGvtYOuH6Xn+s4Lw/gZ39S8VOoZY13eViUvmGMgS+HxmU1DYgglg==
X-Google-Smtp-Source: AGHT+IGFisF1295Ij2x4vO/0+LvR+AVsOSL///qInuAxURZWY7CGHJ9Maj35pV/npREH2JNW8qXFIw==
X-Received: by 2002:a05:6a20:c420:b0:19b:1e87:5a6c with SMTP id en32-20020a056a20c42000b0019b1e875a6cmr2159488pzb.79.1705970161063;
        Mon, 22 Jan 2024 16:36:01 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id w20-20020a170902d11400b001d717e64f0esm6400820plw.87.2024.01.22.16.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:35:59 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 68/82] PCI: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:43 -0800
Message-Id: <20240123002814.1396804-68-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1740; i=keescook@chromium.org;
 h=from:subject; bh=nGybLOIsuTz/Gb9B1iN3NLpbKPO1DsQM9K1PTfrNPdM=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgLXzUyFv8ROCBAkarbyBq08JOy1Jiw/R0yL
 UURfO04CTOJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICwAKCRCJcvTf3G3A
 JuF8EACyGcPp93JqF5tp2S7pbgmh+m2YVe5oYzmcs4GyaCIJEg5zXT/fdkd6tu2LWmWPsIg40Fr
 SbKeYY5YJaOP/yC8bfFrSsUOCoCQFIOLM4SkZgOC3hAJtNPv+NG31XNwAmBQ3ogTFje0YjRk7qX
 OYSeEqoBDlAMmU4ce5qwEHM06VtNVtQCVNp5oulK1zW8BMSBgHMTXzBijtO/DtiBVki8i41z0wI
 5ErrZ+PQQvnc9zRdALPpt5gb/S8dIR7TKzb2KvbM6frT9lAgHflHE9pO5u1EhFtAejTqdWrGrN6
 pz7/2Fv4SETQBDdstfnc15QJJZCgPscQjsL9qw7dy5mLg+E40l1MBYJXivSBEyHPeiVE6vgl8xb
 9P5WqEdq1qfxNLckOqUq9TrZNeGxgxaio+1lM+9xtkKqRSW145a7mRn0Drc9DMHh0KKsUX5TNLk
 xCrBbdKnNhC+Jeqa6I6f6WQW9MgVjNkA17fQdWf/jxsjsf+JGxlVE1livqEEMJbpn66rbvl8iW4
 ypcRIykksrriHbd1C2Aq0g4i9QdSGL/ol0MeuQ2Q92JZUf05lKqbOyhUGChwz26XkLS4M9lRwh5
 usd0VpO9+Y4iU3JXhrCoN2j8ab6+8PU3rZesVh+i68xSHd06pfjnsC0JJQjMi9vWmUHq7sCOINd cznG4a3YV1rp9VQ==
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
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..ebf6d9064a59 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4251,7 +4251,7 @@ int pci_register_io_range(struct fwnode_handle *fwnode, phys_addr_t addr,
 #ifdef PCI_IOBASE
 	struct logic_pio_hwaddr *range;
 
-	if (!size || addr + size < addr)
+	if (!size || add_would_overflow(addr, size))
 		return -EINVAL;
 
 	range = kzalloc(sizeof(*range), GFP_ATOMIC);
-- 
2.34.1


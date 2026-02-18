Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2809348866;
	Wed, 18 Feb 2026 19:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443594; cv=none; b=puFnLLRu6kgcMbB8Lq8Y2PZDrTqRJNVEHl/DdwhRiBcEV7FyZz1H7EN3Y/sgQQplLcdwMfT7NSqo2e9yaF7/nxxoujdpYGpcvCPX4NC1LeyoSHAb7hFOso6583oE7t+bzb+BHJRe5MKgHq8ZUKsuj0VnxvbYY53OIdto/oBP6v0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443594; c=relaxed/simple;
	bh=5zwLJxAdqchjiMXOQ8sg/74TkXMsFztsBEQlruEjDMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hcgie+ozQX/0SmmNvi/hXsn4agGKd4BkdeAbc3Nl3t0zpFyJQeR11sHURIDLNDI6EtbQyh4B3jBoPxVizVQopZEe5HdJ4/nuS26mR4vmbsIk0hphsPrQkiSc6IjOxvcsDM/ccksRY0hDrNWXHag5EFwYJdABNPxo1L+u+kYmepk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Od0/k1jo; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Od0/k1jo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=LhzPBtBKkxJgsnXYzDZMx8HN4KoCg0JnzMqoRZnAwYY=; b=Od0/k1joH52qj2wqPl799YRUyg
	5DlMlaAJ97ds7+4SvxlWaxtHZz5+bdRDYNhR6rjb+LaOkG0pxAVXJFNLD3qQuczATGJ3lzccA6ZoO
	zAsFrZRh22R7jUBBceggFsMyZTQ7/6LLU9LgF7JnwxYbhoApT4b5uORXJs7CxgWBld/EgUS9new6X
	N5KU8SZCo7VEOYILlzZQW1oPC+T3mU7lev1s4noDKsHSfuO9q+MKRQu+Iokl4kRgu907/UUQrF26Y
	fRGFnli9BI+Z4xnYSjLx8JBoLVBlzaYhZ+A7GSYhQIrOdegLtdFa9gteWkmpvj5TXq869HfG5HOYw
	HEWMlhEg==;
Received: from [177.45.213.208] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vsnOo-002BdK-CL; Wed, 18 Feb 2026 20:39:50 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	tony.luck@intel.com,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 1/2] pstore/ramoops: Remove useless memblock header
Date: Wed, 18 Feb 2026 16:37:31 -0300
Message-ID: <20260218193940.912143-2-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260218193940.912143-1-gpiccoli@igalia.com>
References: <20260218193940.912143-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seems the linux/memblock.h inclusion was added early on due
to usage of some memblock allocation routine. But that was
removed, header was forgotten, hence let's remove that.

Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>
---
 fs/pstore/ram_core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pstore/ram_core.c b/fs/pstore/ram_core.c
index 7b6d6378a3b8..481d9c95e0c6 100644
--- a/fs/pstore/ram_core.c
+++ b/fs/pstore/ram_core.c
@@ -12,7 +12,6 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
-#include <linux/memblock.h>
 #include <linux/rslib.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
-- 
2.50.1


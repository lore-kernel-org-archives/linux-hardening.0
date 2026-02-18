Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB9C34405F;
	Wed, 18 Feb 2026 19:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771443592; cv=none; b=sT/5Xm9juGNbmoSjQk8rDOVjg4qNrCWhiKOLjOseUeJzfPuqhuRJdNBhYhEvCMpBIMCo0/ioMlT8ffOVYYKIf5qkKWopv4UywZqtBlbjzwl/t+oPyni9xrUF9W8o61+9RUioKdUyubXxG4jhX/Or3Ibi+uu1sqLIwmcVLTaBups=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771443592; c=relaxed/simple;
	bh=ev93KGT0cOlqWzM23NiRcUgDGrJCsqcMOiYpN3urFjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MNBB8pLgZu1ZuwZfnNxB5cepZjoUFYrqqfbb1dSRSuKOhzngZ6R+s56YStjNkvlw4qqgHLTINLAwMp8iEM/cZu5esEoCrO3YtiQh4XxMlVsNR6eSUICs+67QEOCG2hh/cZLAaZl0VbB0sBHRt5DQFGH8ft87NPqL1o/tJEhUynM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=fe00PtSH; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="fe00PtSH"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=Lr8djXhlgrFpRnQ5MnfXZprfnemxyXbE72vdWUDeOyI=; b=fe00PtSH/sB0WPVirqDWt1bmny
	8cXVYZ0PqxrMQRvfZ4DgHW3FyGg2DYXQnTa5Np6gzzxozVOk/tssQ6rOvTEq5ktkkyrcn2F9aDfOy
	WdavGzLhZVRUGntXHE8E9v2PRO2+OXQg0XXYSOz1PO1LOnbj8no9t3R1jaWxwdI1Ii0T1ZedbT3Nm
	hPXh/hFIK5r+30PNX9GBSf1hguGChMEqdcFcP6jH2cH8M+2k3Yb4v0MeDlww9YWGFwpEtWfWLs+eG
	c5H7KOoAt89XbVGyQulYFP6BFY2kl5Hm5aSqSfOzMhaTZI9BQJqiQVzHuJhsAy99pOdoXouYB7jo1
	5B2yTtpQ==;
Received: from [177.45.213.208] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1vsnOi-002Bcv-Nf; Wed, 18 Feb 2026 20:39:45 +0100
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: linux-hardening@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kees@kernel.org,
	tony.luck@intel.com,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>
Subject: [PATCH 0/2] Trivial ramoops fixes
Date: Wed, 18 Feb 2026 16:37:30 -0300
Message-ID: <20260218193940.912143-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A pair of pretty simple fixes to ramoops: unused header I noticed
by accident and a bogus parameter description (that led modinfo to
show 2 ECC parameters for ramoops).

Thanks,

Guilherme G. Piccoli (2):
  pstore/ramoops: Remove useless memblock header
  pstore/ramoops: Fix ECC parameter help text

 fs/pstore/ram.c      | 2 +-
 fs/pstore/ram_core.c | 1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

-- 
2.50.1


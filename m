Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172C3F929B
	for <linux-hardening@vger.kernel.org>; Tue, 22 Sep 2026 21:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790112366; cv=none; b=qiTUrP5i2KCCVjAMcVcyXhZZ7ZKBqCT0B8k3AyYlP/BPjkzr5xzNT4RMlkpxBN0nWaiDwoNbcCGJsuiGQwj7UW+b4oVIx6qherbk2MvGvOVmW41elzHyDhfYGuHa77/C6T0clqVLxhxRhhsXo4hHE4KnvgOtPEVYox5IzcWIpIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790112366; c=relaxed/simple;
	bh=pRvLRnNqjl4NavmLcb0oq80qGP3p40HYwb8R9HBH0pM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jj0NAECo3wXxo1M8nCgsYVHt45D/82bM9WyWGFVPSLcxOFXUwiokfzWzGih4r8AZtWLbY+O4tjfVzC7ZHIO/iVd+CbFHgCDpobuAdAqOhA7Bwn6lyCJtHGvN2tdT6aQKjjAxmb9fwMGWSeTS/ss+OJo3Vcr8E8UbBIydBbLTBj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FmZkdvEv; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FmZkdvEv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=/OdzoMxY1LHVJUbfo2ByPq951RL3EZvF93kLFtfqJhw=; b=
	FmZkdvEvmQErCmYP9+PxqG0Qst47aV0tJJ/9pD2uywOAHbprtkZP5dnAeI+qZdQjftr6f7nPmM5Sn
	GU0iQDoUmO7GnfstzH58Es5w+wJ0frq+aYu2P6Ooa3ijui6mXVrvofOLfKYrzD+d/7WfFAlelB4B5
	SeK84sDXWtpahi+9D4NpQr936zQ8NgGyW30CtuYdHf8GAx23LQWDbdVopC+JHu9NlskFVHaV/j9zG
	ZTFPuz/DOrEJW5lyMfhB8d5F8LTnaXA7pt5Kz+RduYUsXrjUmj4+JZiibNhmEY/RdP9a3+Ci/XOlz
	4KG7tOZOCo//N9/wO66RupyA/Fx9vS/J4A==;
Received: from [191.32.244.140] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1x97zm-005ppQ-Tj; Tue, 22 Sep 2026 23:25:47 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kees@kernel.org
Cc: tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net
Subject: [PATCH 0/2] Small improvements on pstore user experience
Date: Tue, 22 Sep 2026 18:19:00 -0300
Message-ID: <20260922212532.98571-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kees, Tony,

Here are some small things I've noticed in pstore usage that annoyed
me a bit, so it's not they must be fixed - no bugs here that I can't see.

But the fact kmsg_bytes can be changed via mount option but I can't
write on its sysfs parameter, or that I can set compression to like
"zstd" even when PSTORE_COMPRESS is unset, is a bit confusing to the
point I tried to improve them with these patches heh

Thanks for reviews and comments, and feel free to reject them if in
your opinion, they make things worse.
Cheers,


Guilherme G. Piccoli (2):
  pstore: Consolidate compression handling in both init paths
  pstore: Allow kmsg_bytes parameter to be written at runtime

 fs/pstore/platform.c | 42 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 8 deletions(-)

-- 
2.50.1


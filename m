Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A3226AA91
	for <linux-hardening@vger.kernel.org>; Tue,  6 Oct 2026 20:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791318870; cv=none; b=tkzYYw2mOr9+qOVFbHz35+jWjlYQ8ry2mnDq15p0bmCuBZdloQVNMuoeksk9+CEQkPLnD/Ye7EHinEorvPhRapPFJtPXkPXSbDYrG+aVyai9Wp9nvQ+NA09szmEE6oMbBTrIykzdQxBJ/OAEPC7j9gSiCEjCmxXX6goh2KSEBnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791318870; c=relaxed/simple;
	bh=H83w01QOhpdKQ1UAW9PaYaI68lmgbixZr6cWF621kPM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FdgPpjAGqL7YleZLAAk+H4ZPTaF8DLWlrLa5n/HzpWE480Em+yvVlPtl0LwjMTIz1a6Vnc9c3a1UOliKs4gfnJKHbovj2vOC7O6FwloOPSfhGrQ9Y5tS1vCLtk/kdTxXMf4kq6cjFOXXKUqtMkNK5+o9q9LxwEWLzWai2prHk6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Xc/5vZJL; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Xc/5vZJL"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:From:Reply-To; bh=FgUiY2i5W0sKRTUpJ3LGY9dHHIO/rrOyClWJtJtBeLE=; b=
	Xc/5vZJLwhih5TbhJGDnYsr+C1IMyyBat/gHMLLZErV0v9JtRn5iJm7Ib9+ZvsVlnehVGHzoXVXX3
	SxQizl2wYFTCLmg6QJVZVtxdyLmHWtr3CtInDoaU+EUvQ/3mPLt9zZ9dvtg3k8HUT4WWUR0eCxQdr
	aGK13uIAUnAz6x9AwBIZ3YYSPMnrQa1jb/s/5IJAWErGsH90chLy4BteuxGH9pRNLNVhY50ewAh3v
	ZplrgG7bz2ktgYCEu4DzSE7PR2zob/3vIRTWBNp4kNsICBPGzxfaMq4+wDbJI7n18+SMKlxvaUQpP
	zo58sfPLiEh+2T51HK22qU2ASCyG8IJUzQ==;
Received: from [187.90.178.110] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1xEBre-00DcJr-HR; Tue, 06 Oct 2026 22:34:18 +0200
From: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
To: kees@kernel.org
Cc: tony.luck@intel.com,
	gpiccoli@igalia.com,
	linux-hardening@vger.kernel.org,
	kernel-dev@igalia.com,
	kernel@gpiccoli.net
Subject: [PATCH V2 0/2] Improvements on pstore user experience, take 2
Date: Tue,  6 Oct 2026 17:22:50 -0300
Message-ID: <20261006203412.175427-1-gpiccoli@igalia.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kees, Tony, all

here is the second iteration of the patchset.

V1 here: https://lore.kernel.org/r/20260922212532.98571-1-gpiccoli@igalia.com/

The main changes of this version are related to potential races Sashiko
caught, and are hereby addressed (hopefully!). I put the diff V2/V1 in
each patch. Lemme know if there's anything else to improve and thanks
for reviews/suggestions!
Cheers,

Guilherme G. Piccoli (2):
  pstore: Consolidate compression handling in both init paths
  pstore: Allow kmsg_bytes parameter to be written at runtime

 fs/pstore/inode.c    |  8 +++++---
 fs/pstore/platform.c | 44 ++++++++++++++++++++++++++++++++++++--------
 2 files changed, 41 insertions(+), 11 deletions(-)

-- 
2.50.1


Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663AE248864
	for <linux-hardening@vger.kernel.org>; Wed,  2 Jul 2025 09:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751449944; cv=none; b=YJa9CqlCI10CSATbK96QdgxJup3BYcXUTwQspBMSjPgf1JLhBaZtTxVQ/Yq3wI1sdm4txT6EWT7ZP3K5k5NI9ybCmLlJJgaSP7pxdGth175MTyG149An5dFviKy/N0pwSLYzEAFhr/vVWk5ZCXKhT383B3xF54xJyYaG5DxnJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751449944; c=relaxed/simple;
	bh=nWguKm98NSzK4z+eOPTSvPWnNpe9yhLlYOSHW7pDYPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lk/XGyacYAxIHxM5F3+EeM8wOoeDEH2LBwcsHcnC3dyKQcONrtEQttAgtKxJPnzhBcZZyIanODPaNQtFrJ4utGe4iau85GWK1XGRwR45SfPGnJURvnZLPjWAUU2O8TqoI113rQPsF+WWrvuNlKYzICsQhG9OOAFOPUUB2hcGGFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jE3U8Tmb; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=jE3U8Tmb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jE3U8Tmb";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="jE3U8Tmb"
Received: from pathway.suse.cz (unknown [10.100.208.146])
	by smtp-out2.suse.de (Postfix) with ESMTP id 4253D1F445;
	Wed,  2 Jul 2025 09:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751449939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7oYXkeMUJuIJ1tp286p2B7f7F5Z4QHeSEILjcK1G4+o=;
	b=jE3U8TmbU8snttgEbj3Gl+Ik3CZElBUEV4s+wvUjFfc6KhfPOWeT3yJhXxnx5+f67eNG7G
	VBOWfUrNNo9UX+A+xLER+sXJlOPtI1d298PeGn+LCyifMP4fj81Vb372DBdecbjVfvjvOk
	76TYzU3dD+hs4Cf9jNX43XMkM/MMYjg=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751449939; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=7oYXkeMUJuIJ1tp286p2B7f7F5Z4QHeSEILjcK1G4+o=;
	b=jE3U8TmbU8snttgEbj3Gl+Ik3CZElBUEV4s+wvUjFfc6KhfPOWeT3yJhXxnx5+f67eNG7G
	VBOWfUrNNo9UX+A+xLER+sXJlOPtI1d298PeGn+LCyifMP4fj81Vb372DBdecbjVfvjvOk
	76TYzU3dD+hs4Cf9jNX43XMkM/MMYjg=
From: Petr Mladek <pmladek@suse.com>
To: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	John Ogness <john.ogness@linutronix.de>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	David Gow <davidgow@google.com>,
	Arnd Bergmann <arnd@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Petr Mladek <pmladek@suse.com>
Subject: [PATCH 0/3] printk: KUnit: Followup fixes for the new KUnit test
Date: Wed,  2 Jul 2025 11:51:54 +0200
Message-ID: <20250702095157.110916-1-pmladek@suse.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_ZERO(0.00)[0];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:mid]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -3.30

Hi,

this patchset puts together some followup fixes for the new KUnit test
which were discussed on several locations.

1st patch:

  + adds a comment exaplaing why the test ignores pr_reserve() failures.

  + was proposed at https://lore.kernel.org/r/aFUiQESkXjFIGqez@pathway.suse.cz

  + Thomas Weißschuh added into v4 of the original patch but I have already
    comitted v3 in the meantime, see
    https://lore.kernel.org/r/20250620-printk-ringbuffer-test-v4-1-8df873f1f3e0@linutronix.de


2nd patch:

  + dynamically allocates a cpu bitmap to make the code safe even on systems
    with many CPUs.

  + v1 was set by Arnd Bergmann but it had some problems, see
    https://lore.kernel.org/r/20250620192554.2234184-1-arnd@kernel.org

  + This version just integreates the proposed fixes from
    https://lore.kernel.org/r/aFkuqaFn3BOvsPT-@pathway.suse.cz


3rd patch:

  + stores "size" instead on "len" in struct prbtest_rbdata so that
    is can be used to check code sanity by __counted_by(size).

  + fixes https://lore.kernel.org/r/eaea66b9-266a-46e7-980d-33f40ad4b215@sabinyo.mountain

  + it is based on the idea from Thomas Weißschuh, see
    20250626082605-c5fbbb88-f6cc-4659-bea0-a283cdb58e81@linutronix.de


Sigh, I should have asked people to send new patches. But this looked
easier and I wanted to clean the table.


Arnd Bergmann (1):
  printk: kunit: support offstack cpumask

Petr Mladek (2):
  printk: ringbuffer: Explain why the KUnit test ignores failed writes
  printk: kunit: Fix __counted_by() in struct prbtest_rbdata

 kernel/printk/printk_ringbuffer_kunit_test.c | 78 +++++++++++++-------
 1 file changed, 52 insertions(+), 26 deletions(-)

-- 
2.50.0


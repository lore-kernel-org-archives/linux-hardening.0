Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.83.222.40
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795575491;
	b=GD4s/9p+jL6xdiAHUDKavDUL+aQmnPnDVQ6nXi7dgmqfMHY8dDkPKyrWunDj3NlFtD2y
	 dAGJOmOAdhVa+slzjE6T7h+/jxS71tAwKil8EI+pHxlJ1DhymOuPWrQMNcguoAvEGw2P8
	 LDMeNsGjmE59jW+b4u3XlAIFvDjPpbihjHPguM9rKh+NuJ9L6w8+nMK7sYTPj2Bl6TxKA
	 JLG/zIToKnmxczEw89N6NzXlya10/9nTonu72jOeLeIdV4LynfWI1KS1Pe3fXeUNq5QJk
	 g4mFLWWkEHi+HFeVzM4oEfxhWh7JG8yQ/GhBL8EZ6kMbapWZR+bUdEP/fjhtyG5Oymw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795575491;
	h=DMARC-Filter:X-Sender-Id:Received:Received:X-Sender-Id:X-MC-Relay:
	 X-MC-Copy:X-MailChannels-SenderId:X-MailChannels-Auth-Id:
	 X-Cellar-Cellar:X-MC-Loop-Signature:X-MC-Ingress-Time:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-AuthUser;
	bh=hsWRqvlnSPIR2F6gY8CRs4jFUdQZq/jxCGYtqXKn8TE=;
	b=ijKTnJq4V7QYRGzNC9+b8qKq0s9+sr1EpjD4+FW5FzNRzIHDsnMHq1V609i1D/AD1Zkz
	 Q9Gj2MKYWArtpOGuRM193d0Bv+hR9NAiQETu6ndXLSLiAiAfjjfcNXU4NmQWmVMEhl7fp
	 NMkDmHWeyLr6DvZa6RRL77FlSPMGlgAJuUaYMcXQNoom4FhWumPVAAOCKmtVdHCE47hWC
	 fdoTHnxWz1lnGhWLAQ+mehfK0zlAPn6iCOkI2cnnE5mInzho271YjN4cKcoDBJOzsOXrl
	 jbh6g4GJ35bEHuO19DcASEy8Tb3wwG9a6Z71IqSLhrUQd8AvHTdPET0gYJHqLEMyC8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=sim.vu;
	spf=pass smtp.mailfrom=sim.vu;
	arc=none smtp.remote-ip=23.83.222.40
Received: from cornsilk.ash.relay.mailchannels.net (cornsilk.ash.relay.mailchannels.net [23.83.222.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E388F606A321;
	Wed, 25 Nov 2026 02:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E388F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sim.vu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sim.vu
X-Sender-Id: instrampxe0y3a|x-authuser|brad@sim.vu
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 31ADC4019B2;
	Wed, 25 Nov 2026 02:58:04 +0000 (UTC)
Received: from cpanel-010-lon.hostingww.com (trex-green-5.trex.outbound.svc.cluster.local [100.96.23.111])
	(Authenticated sender: instrampxe0y3a)
	by relay.mailchannels.net (Postfix) with ESMTPA id CD7704012AD;
	Wed, 25 Nov 2026 02:57:58 +0000 (UTC)
X-Sender-Id: instrampxe0y3a|x-authuser|brad@sim.vu
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|brad@sim.vu
X-MailChannels-Auth-Id: instrampxe0y3a
X-Cellar-Cellar: 27dacd100249e60e_1795575483987_1197842351
X-MC-Loop-Signature: 1795575483987:1605370920
X-MC-Ingress-Time: 1795575483987
Received: from cpanel-010-lon.hostingww.com (cpanel-010-lon.hostingww.com
 [18.130.191.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.23.111 (trex/8.0.2);
	Wed, 25 Nov 2026 02:58:03 +0000
Received: from 162-195-230-196.lightspeed.wchtks.sbcglobal.net ([162.195.230.196]:41714 helo=epyc.attlocal.net)
	by cpanel-010-lon.hostingww.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <brad@sim.vu>)
	id 1xW3Ck-0000000BJbh-1ytC;
	Wed, 25 Nov 2026 02:57:56 +0000
From: Brad Hawthorne <brad@sim.vu>
To: linux@armlinux.org.uk,
	linux-arm-kernel@lists.infradead.org
Cc: kees@kernel.org,
	gustavoars@kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: xip: end _etext before the read-only data
Date: Tue, 24 Nov 2026 20:56:50 -0600
Message-ID: <20261125025650.1159785-1-brad@sim.vu>
X-Mailer: git-send-email 2.43.0
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: brad@sim.vu

The XIP linker script sets _etext after the read-only data, while
vmlinux.lds.S sets it at the end of the text. Hardened usercopy
refuses any copy to user space from _stext to _etext, so with
XIP_KERNEL=y and HARDENED_USERCOPY=y, copying a const string from
.rodata to user space ends in BUG(). The first readdir() of /dev is
enough:

  usercopy: Kernel memory exposure attempt detected from kernel text (offset 2955300, size 1)!
   __check_object_size from filldir+0xd6/0xfc
   filldir from dir_emit_dots+0x34/0x80

Commit 14c4a533e099 ("ARM: 8583/1: mm: fix location of _etext") moved
_etext in vmlinux.lds.S for the same reason; the XIP script was
missed. Set _etext at the end of the text there too.

Tested under QEMU (mps2-an385) and on an RP2350 board, both XIP: the
BUG is gone and directories list normally.

This patch was written with an AI coding assistant (Claude Opus 5.5,
Anthropic): it found the cause of the usercopy report, wrote the fix
and this changelog, and ran the QEMU and board tests; I reviewed the
reasoning and the test results.

Fixes: dfd45b6103c9 ("ARM: uaccess: Enable hardened usercopy")
Cc: stable@vger.kernel.org
Signed-off-by: Brad Hawthorne <brad@sim.vu>
---
 arch/arm/kernel/vmlinux-xip.lds.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/kernel/vmlinux-xip.lds.S b/arch/arm/kernel/vmlinux-xip.lds.S
index 5afb725998ec..76e024cc50c9 100644
--- a/arch/arm/kernel/vmlinux-xip.lds.S
+++ b/arch/arm/kernel/vmlinux-xip.lds.S
@@ -58,6 +58,8 @@ SECTIONS
 		ARM_TEXT
 	}
 
+	_etext = .;			/* End of text section */
+
 	RO_DATA(PAGE_SIZE)
 
 	. = ALIGN(4);
@@ -71,8 +73,6 @@ SECTIONS
 	ARM_UNWIND_SECTIONS
 #endif
 
-	_etext = .;			/* End of text and rodata section */
-
 	ARM_VECTORS
 	INIT_TEXT_SECTION(8)
 	.exit.text : {

base-commit: aebb7274476403040d582c61478df8f4a7bf9cd3
-- 
2.43.0


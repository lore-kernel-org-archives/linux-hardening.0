Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A182A47A0B5
	for <linux-hardening@vger.kernel.org>; Mon,  5 Oct 2026 10:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791197557; cv=none; b=dCAI73snB1g+SzBznsDjKaYrHRezYUrYvOGtUwVtIMAUaRe1MHyQF929gRW66nX7LIEFm/PabBbFtEAFxs0OpI/VfqKI9Z653XyjMOwoO8UcNdEwDbbB1IwJZxatPwJvS7McHVKPWQmIwZT+MX5VbHHUMeLUMPhDMqupP9Mrwbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791197557; c=relaxed/simple;
	bh=6TcruxHJ7ekNaEndesSgJuNKG7TYIG/4ORqE4fSG0rM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ExY6+5y9/iDS5nFD0gNSA/SLJ5p/99goLLK1LYssI3vWH1FXIG3bT5fLH1hca1F6IYQXSaQD/4DeS2WpmMHWLTm/Jjkaj85QrcuP9c6TBguaubHEBxISzuf1GGA8L0n2I/lBubJzr0++bC7khWdm3YQNlg51hRAg+VEfHW/PCR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hveYZNSG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hveYZNSG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791197554;
	h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:in-reply-to:in-reply-to:  references:references;
	bh=WzZZ1vjk1HpFh02oj566hC6J1Vi5MA3uxumxflP2oTY=;
	b=hveYZNSG2iEE4XYbtEa0YxDoVbMu2WYpcFbbgQ2Hz/2YspzxmYs7k/6y3oWPRK3q57fyP2
	r6f2KjLX6or2GXdybFEHzIXa4EUPQbeLQlSTJhDt7/lLhg2VvZVNncjNw2KL2lX3mT1eS/
	J9tLPm/cOThBZ6RCo0WHENXCqlzTOlo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-418-lVD4vvPpPZOpgAM35KULvQ-1; Mon,
 05 Oct 2026 06:52:33 -0400
X-MC-Unique: lVD4vvPpPZOpgAM35KULvQ-1
X-Mimecast-MFC-AGG-ID: lVD4vvPpPZOpgAM35KULvQ_1791197550
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FA4E1956068;
	Mon,  5 Oct 2026 10:52:29 +0000 (UTC)
Received: from tucnak.zalov.cz (unknown [10.44.48.19])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8851E1956047;
	Mon,  5 Oct 2026 10:52:26 +0000 (UTC)
Received: from tucnak.zalov.cz (localhost [127.0.0.1])
	by tucnak.zalov.cz (8.18.1/8.18.1) with ESMTPS id 695AqMnS4072328
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 5 Oct 2026 12:52:22 +0200
Received: (from jakub@localhost)
	by tucnak.zalov.cz (8.18.1/8.18.1/Submit) id 695ApmeD4072327;
	Mon, 5 Oct 2026 12:51:48 +0200
Date: Mon, 5 Oct 2026 12:51:45 +0200
From: Jakub Jelinek <jakub@redhat.com>
To: Kees Cook <kees@kernel.org>
Cc: Andrea Pinski <andrew.pinski@oss.qualcomm.com>,
        Jeffrey Law <jefflaw@qti.qualcomm.com>,
        Joseph Myers <josmyers@redhat.com>, Richard Biener <rguenther@suse.de>,
        Martin Uecker <uecker@tugraz.at>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>, Jan Hubicka <hubicka@ucw.cz>,
        Richard Earnshaw <richard.earnshaw@arm.com>,
        Richard Sandiford <richard.sandiford@arm.com>,
        Marcus Shawcroft <marcus.shawcroft@arm.com>,
        Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
        Kito Cheng <kito.cheng@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Waterman <andrew@sifive.com>,
        Jim Wilson <jim.wilson.gcc@gmail.com>,
        Dan Li <ashimida.1990@gmail.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ramon de C Valle <rcvalle@google.com>,
        Joao Moreira <joao@overdrivepizza.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Bill Wendling <morbo@google.com>,
        Osterlund Sebastian <sebastian.osterlund@intel.com>,
        Constable Scott D <scott.d.constable@intel.com>,
        gcc-patches@gcc.gnu.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v16 4/7] x86: Add x86_64 Kernel Control Flow Integrity
 implementation
Message-ID: <asOBQfGfzUOX4uFq@tucnak>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20260902164928.stay.466-kees@kernel.org>
 <20260902164935.1390773-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260902164935.1390773-4-kees@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZEtpVSfqc71YcongEfyrnM2DoedcxheJyewxkT5vaq0_1791197550
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 02, 2026 at 09:49:29AM -0700, Kees Cook wrote:
> +** movl	\$-?[0-9]+, %r10d
> +** addl	-4\((%r[a-z0-9]+)\), %r10d
> +** je	.Lkcfi_call([0-9]+)

What is reason to use movl + addl instead of just cmpl?
I mean,
int foo (int *p) { return *p == 0x12345678; }
is compiled into
	cmpl	$305419896, (%rdi)
so I wonder why you can't just compare -4(%r11) with
a 32-bit immediate.
Are you trying to avoid the immediate to be present in the insn
sequence, so that nothing can do an indirect call to the insn after this
compare?

	Jakub


Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576E535CB75
	for <linux-hardening@vger.kernel.org>; Fri,  9 Jan 2026 13:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767966633; cv=none; b=ZhJNSgmSqBIlmnTqC0YitWZBhEu66/yoQ6NifRn+HFYhAw4asB62lb1gHlFnSa4AYRf82qXX/dXsBPAZPPtvoGM1lUD43+Q4ve6l1I/CsFG3m/FzaxPoHAi8eTV6DUTdRKVAGxX+IohrMt8kZHgifcKEaPLDFCGRWDwRu8temis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767966633; c=relaxed/simple;
	bh=7zjuKf+UIxL3bVA44Jw3Yx6helDynPKRicBwZQnETMM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WrHM5xSubKeaIoE7sFwgfPLOtbtq22xLVwig0ez49XYf/WHMFGVScdg+4hwNYVVVT9X5eg4124tvB0xulJpJwhM3nY2h1OjxlLRRUeIADbEC53HGUv2YBvk8S7gYcK6iqPjcxctZS0+j3sSEEI4bbEG+2+gpnCrHXUDRTyFKII8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d0aTQxGs; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d0aTQxGs"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id E61F21A272C;
	Fri,  9 Jan 2026 13:50:23 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B428E606C6;
	Fri,  9 Jan 2026 13:50:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EE4EA103C8329;
	Fri,  9 Jan 2026 14:50:19 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1767966623; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7zjuKf+UIxL3bVA44Jw3Yx6helDynPKRicBwZQnETMM=;
	b=d0aTQxGsylzWCcJ5fUfL8+ZNebSEojE2M/GcU0sjfELjBB41JEP78+mhpOsqLNVRRdgqB5
	EoucvonRbo3e914sIVvlidNUHYWsEPClnCO9pKYvAd3mnNMFW/gI1PwNLsG0mHhrJ7IfRh
	rixwSyhKoIwZ1vHTVdICtZCC0a/RMFCfu6sILe8sAU8fMgGRlj0ikxutSud32ieKdgvPVX
	kJSGCyhHNubMt7NDeqZfUuq3HuvwGsd0a+7F9febBhoefUyU/CUg4IRjdQpk+2tiBlhADp
	r8fuKUqHaNiTa4wu1pcNc/YiVHiKe6MhsE3n3QflzWzvy+rSy/3r5WrAv9ta0A==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: Randy Dunlap <rdunlap@infradead.org>,  "Gustavo A. R. Silva"
 <gustavoars@kernel.org>,  Alexander Usyskin <alexander.usyskin@intel.com>,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Rodrigo Vivi <rodrigo.vivi@intel.com>,  Tomas Winkler
 <tomasw@gmail.com>,  linux-mtd@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linux-hardening@vger.kernel.org
Subject: Re: [PATCH] mtd: intel-dg: fix array-index-out-of-bounds in
 intel_dg_mtd_probe()
In-Reply-To: <aWDNNOoYTa0Mi7LM@black.igk.intel.com> (Raag Jadav's message of
	"Fri, 9 Jan 2026 10:41:08 +0100")
References: <aUZFLezigzZQVt55@kspp> <aUZLNTOMgvJ8WrIy@black.igk.intel.com>
	<0c69b711-4c88-4e64-afe7-f7de147a490b@infradead.org>
	<aWDNNOoYTa0Mi7LM@black.igk.intel.com>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Fri, 09 Jan 2026 14:50:18 +0100
Message-ID: <87a4ymyjxh.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On 09/01/2026 at 10:41:08 +01, Raag Jadav <raag.jadav@intel.com> wrote:

> On Wed, Jan 07, 2026 at 03:17:40PM -0800, Randy Dunlap wrote:
>> Hi,
>>=20
>> On 12/19/25 11:07 PM, Raag Jadav wrote:
>> > On Sat, Dec 20, 2025 at 03:41:49PM +0900, Gustavo A. R. Silva wrote:
>> >> Fix the UBSAN: array-index-out-of-bounds issue below by updating
>> >> counter nvm->nregions before the first access to flexible-array
>> >> member nvm->regions[].
>> >>
>> >> from kernel bugzilla:
>> >> https://bugzilla.kernel.org/show_bug.cgi?id=3D220823
>> >>
>> >> Dec 15 22:01:52 orpheus kernel: UBSAN: array-index-out-of-bounds in
>> >> /var/tmp/portage/sys-kernel/gentoo-kernel-6.18.1/work/linux-6.18/driv=
ers/mtd/devices/mtd_intel_dg.c:750:15
>> >>
>> >> Notice that this flexible array is annotated with the counted_by()
>> >> attribute, hence the counter must always be updated before the
>> >> first access to the array.
>> >=20
>> > Already fixed[1], but not sure if it's landed yet.
>> >=20
>> > [1] https://lore.kernel.org/linux-mtd/20251111-mtd-nregions-v1-1-61db6=
1e78c63@intel.com/
>>=20
>> What's the status of this patch, please?
>
> I'm assuming it'll go through mtd tree? Miquel?

It should indeed. However only the mtd list has been included, so it
won't appear in "my" todo list. Lucas can you please resend, and use a
tool such as b4 to manage the series or at least run get_maintainers.pl?

Thanks,
Miqu=C3=A8l

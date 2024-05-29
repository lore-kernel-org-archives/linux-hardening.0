Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E89D167D82;
	Wed, 29 May 2024 07:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968673; cv=none; b=pXBfQxUgvBh/1O5hEDJpBmgLXTV1dQBZW7iQOAAk9kKkDJTyeypy9UkbDhf5FI6OHIw5xnQFPyxZymROFSs+9/w1pH93GpRQ+by3l5Ua8wd+tIgl+/AEj9mqn/kAc19CcUh/gtfyAkJ+uM/4c9wZsQT+XML9NHYRY5Z6NSqLFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968673; c=relaxed/simple;
	bh=l3e4XGMHeqcaFp3c1alhM0SyyJVOB5RJ7bsPdFCYRN8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eCjxwpoEq4EGHul7hmisiRL+cEo/bC+Va4MyTUdy5nJJtGvoKCCYd2mwaZpeK28CSRZ+KnOT4MwtJQ4z+Q4x/5uEPSeLvNkzfYKQIo4xrMMO4oalhkTl8Igxqd+F+q42TXAXrJQ0aK7C6XD+Sjfr47jvbTC1QarKfknJQVKtIjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PO0OiuaF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q7rgiyBu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PO0OiuaF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q7rgiyBu"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1716968670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE7vhuw8E8wyrs8rvI3fGpK9jO0/z9blbeaNe3TtmiY=;
	b=PO0OiuaFLleooo1+dtSkvMQjkTrFudYxYH5KWj6YOvItGVIGS6JxJZbuq8RCbxWBYaTIx7
	s21/4z3VbO6X2qMsQtjfU4DWk3GN6/0ejRB7x/gpo2UQKNorZ2lCuMUmlUKLl5apnwQ7ec
	GQHz3XCGa7m6ILRNSZ86Ij614LFIs44DoJZj0mWP+Ai56Z6HUf3pS8WxMu6lznQbJAvzEh
	gVtSyeQY9dDR6TE44DoQzIrJY8FMcBrI9cW8YSr8d/8o5nVILoIpgdI8J6GVqHxoMm5Zij
	h8//lbHMoCfCSI7AQEN2TKeHFSahkCSuJbzSdvGjZw3WpezkxaH0ZRGMJOhrAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1716968670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mE7vhuw8E8wyrs8rvI3fGpK9jO0/z9blbeaNe3TtmiY=;
	b=Q7rgiyBuaPBuX9ChZ48AH9RKAG5r8XoZwmgSilvIKza7XbFzr6wsuccCBuyuIlvaeuxgTB
	tplYnc+/FnroHHCg==
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>, Dave Hansen
 <dave.hansen@intel.com>, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
 mat.jonczyk@o2.pl, rdunlap@infradead.org, alexandre.belloni@bootlin.com,
 mario.limonciello@amd.com, yaolu@kylinos.cn, bhelgaas@google.com,
 justinstitt@google.com, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Cc: CobeChen@zhaoxin.com, TimGuo@zhaoxin.com, LeoLiu-oc@zhaoxin.com, Linus
 Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
In-Reply-To: <2553dd17-f763-4894-89b7-5f76c03d3a37@zhaoxin.com>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <2553dd17-f763-4894-89b7-5f76c03d3a37@zhaoxin.com>
Date: Wed, 29 May 2024 09:44:30 +0200
Message-ID: <87ikyx9i5d.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 29 2024 at 12:39, Tony W Wang-oc wrote:
> printk deadlock will happened at #A because in_nmi() evaluates to false 
> on CPU B and CPU B do not enter the panic() AT #A.
>
> Update user space MCE handler to NMI class context is preferred?

No.

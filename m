Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02371A2C28;
	Sat, 18 May 2024 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715999627; cv=none; b=JRtgoPO2Fx06KqBRBYTytonpW0AwPTtztBgxa586q4e+WstfttLbH3M3PhZ2zoVc8UNrv+qsGQmVs45aj9y/mzd20Ps1fqZvXWWwzJcX4xYrGUxEINZSUWcgxVZHJ6aY9gPo3N9Cs8grYeb4RHZZUhcDxSqo/MjmaUKaszZLRcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715999627; c=relaxed/simple;
	bh=J4HFcEm0Desk0/Nj0Jwz+Ucyl6I9mE9H5P4VuLhZRKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OoGWfncRkaOKvbPVpkgoFJG4S5UE0FQLFhD1NeSJfJi5Wdl9nYUPDiqqXAkqqHOcXqKDmt5xRWat4FQ3xsOB0pUF8cw4Zk9z1HopbF28ju85P31N6TInnlbH2d1l+KlFVHO44fmcKuR/sTDJL3b1uFnKC6bRXnLbQfcsghESo1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jnk3J6WQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w+/l04Q2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jnk3J6WQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w+/l04Q2"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715999623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55cszT4XzEtPLb/9GTwhCcJ0oLDdirFSqpzcbtqDlEg=;
	b=Jnk3J6WQiE4t34T6M190yU8KzhXKDYxlMwxLSd5BpSSM/rgxFpyHgaph52l/s3zII5LvAL
	8sCyk6y68VYcI/8y6fKbdvq5r2jHQ+u2b0dgCNTFOsj+IjaA9Gqqp9RYkbwZRae+lXRIPT
	lZBrRBPSyPaolV4nLYxPRTdoHu5Sdba+ZIcSKgL7O9Sv3wP0tJxD1thQMMghzLH9cLntil
	WFQoxk4a5O5niBYZGBfGYWGdZ3HhzoVWgVU/7vz6N1ocFkif/yXeB4wvJgsXld+Bfm15gq
	KnoZbW6EPVEvVk+Ah3I8Ksv7nl5EqrSav6VpqgcvTNUM/q9WMq+AO9xff2WGvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715999623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=55cszT4XzEtPLb/9GTwhCcJ0oLDdirFSqpzcbtqDlEg=;
	b=w+/l04Q2KI66hTUqDhQkuTUPAeMPvc8Y5D3Iuk5Ax0tz1kJILDqXIXwS1hpQp3x68tet6z
	MZc1HVWRQNcgtSBw==
To: Justin Stitt <justinstitt@google.com>, John Stultz <jstultz@google.com>,
 Stephen Boyd <sboyd@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Bill Wendling <morbo@google.com>
Cc: linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v2] ntp: safeguard against time_constant overflow case
In-Reply-To: <20240517-b4-sio-ntp-c-v2-1-f3a80096f36f@google.com>
References: <20240517-b4-sio-ntp-c-v2-1-f3a80096f36f@google.com>
Date: Sat, 18 May 2024 04:33:43 +0200
Message-ID: <87pltjj1bs.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin!

On Fri, May 17 2024 at 00:47, Justin Stitt wrote:
>  	if (txc->modes & ADJ_TIMECONST) {
> -		time_constant = txc->constant;
> -		if (!(time_status & STA_NANO))
> +		if (!(time_status & STA_NANO) && time_constant < MAXTC)
>  			time_constant += 4;
>  		time_constant = min(time_constant, (long)MAXTC);
>  		time_constant = max(time_constant, 0l);

Let me digest this.

The original code does:

	time_constant = txc->constant;
	if (!(time_status & STA_NANO))
		time_constant += 4;
	time_constant = min(time_constant, (long)MAXTC);
	time_constant = max(time_constant, 0l);

Your change results in:

	if (!(time_status & STA_NANO) && time_constant < MAXTC)
		time_constant += 4;
	time_constant = min(time_constant, (long)MAXTC);
	time_constant = max(time_constant, 0l);

IOW, you lost the intent of the code to assign the user space supplied
value of txc->constant.

Aside of that you clearly failed to map the deep analysis I provided to
you vs. the time_maxerror issue to this one:

# git grep 'time_constant.*=' kernel/time/
ntp.c:66:static long                    time_constant = 2;

  That's the static initializer

kernel/time/ntp.c:736:              time_constant = txc->constant;
kernel/time/ntp.c:738:                      time_constant += 4;
kernel/time/ntp.c:739:              time_constant = min(time_constant, (long)MAXTC);
kernel/time/ntp.c:740:              time_constant = max(time_constant, 0l);

  That's the part of process_adjtimex_modes() you are trying to
  "fix". So it's exactly the same problem as with time_maxerror, no?

And therefore you provide a "safeguard" against overflow for the price of
making the syscall disfunctional. Seriously?

Did you even try to run something else than the bad case reproducer
against your fix?

No. You did not. Any of the related real use case tests would have
failed.

I told you yesterday:

   Tools are good to pin-point symptoms, but they are by definition
   patently bad in root cause analysis. Otherwise we could just let the
   tool write the "fix".

Such a tool would have at least produced a correct "fix" to cure the
symptom.

Thanks,

        tglx

Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE0613A875
	for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 18:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936698; cv=none; b=lJHkttNORmG/WUSyQ6O3flyDb31k0ayfuU4fzuYbPS4W5832vNc9ErDDTPq/xGBy8xN/eicOBOrX/0rN7IjQ69e3q266cuZztMASxbPF0KukeCXW8l+30SEzSFBS2gWWtCoRXByYbULxJoKGq6nYdCQ1crsCa7D3FEuadyPJ9WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936698; c=relaxed/simple;
	bh=yztsz14R6ZSORaywQr2UjnCMcZQ4jnAvDwH12DaFtns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5nQG3OG1JPmB7txz/2bgOTiEh2wmGTC0xty1ovO1RM8VjPkhl08u/pIuK2+6mT1xVwD6m75JnoUiY8GBdthf4SG5jFiw4fSzLYoufiHQt1qLQbeCIFJua0dUIz5qutjg+opEr0dMx/2pBT5mfVqnPcffxRu73UPZ9i1iWD7CKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=c2fcRsn8; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="c2fcRsn8"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6e08dd0c7eeso93685b3a.1
        for <linux-hardening@vger.kernel.org>; Wed, 14 Feb 2024 10:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707936696; x=1708541496; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7TmoFUzL21SenV8bAqzJot2A9aef5mtokwK00igGrc8=;
        b=c2fcRsn8yA2SUecXStGGxqd3dD3SgzAjMBhF1Y45YGJMoafIRU5Hao01HZXspoG3ml
         Id/zm6Y6cnNwOspX6+0+eIg6fKK80JG8m6Sre16HKcqw8oaWYIjaF14MOjMVSO4wPi1s
         /AZTZBVAtEBdJPwzKc0PPICbEqyzspD3/osRE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936696; x=1708541496;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7TmoFUzL21SenV8bAqzJot2A9aef5mtokwK00igGrc8=;
        b=tSTFG05lyVM4wjLg9hxkaKsvW/u//9Nd5pkj9lfi1GKlvGQaAXtfANxAKIDovaXS1u
         9aQxy/M7vYqkODlleTk75O7ULPXLupnia4VR0+4Nxz8p1qjAVBeM/s/p87lIOpU/na07
         Vs5oubzxWtEf2xqyQ9GpWADhPoLLXgfoyMWCRMCdWBv/qBWG+m+GYjRdhNYpG/hSlrwX
         xZWrbN43TM/P4lQeYX0CS7x8mEJCEVRzN0sptyt1+wNyrc8sxDlHEyJK9eKZWJcpNkD4
         wNHrWYEpK96TFZKQH0R/3d+RG2Y6zdUsmANdQUOje8V37x0HgVPj/pZN1OaHqAFriiAL
         U52w==
X-Forwarded-Encrypted: i=1; AJvYcCUIEaWSqlV56rsFCzYjlnjDeW4Jg4gxfh1ouQZ59611qSabCr0OQaduxOoXm2zf+fppVFwwLKg/C3p7hHInKjdTiEEye/yLwerX166tnadH
X-Gm-Message-State: AOJu0Yy+3tdW2ndhV+wjNlKkX1IG7ciWi4jJiEUHfjLEy9XK2SeGexFc
	HsTEPU/S8QCTPgPJVNsqPWm+oSYiPNSN4ocjaA7QjAo33gVM4wLFcNxlxj+xZQ==
X-Google-Smtp-Source: AGHT+IGMpMrMHQqDLWS4X0fNZ1uf51AX6I2f2KM7gQnV3J2wt5MDkwtly9Gz02VAXaAX6BuS/gwYZA==
X-Received: by 2002:a05:6a21:1743:b0:19e:ca05:226e with SMTP id nw3-20020a056a21174300b0019eca05226emr2888826pzb.9.1707936695883;
        Wed, 14 Feb 2024 10:51:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXMLAk/FbgcU1pBdYFgTgNXr61uUiSeqOEh1Wg9xSjxtdXffq6iZih3qbwHWByg1fS+qrveEXORwYyzlGZhfHem1fPLxPktdGzZzHn3Uz2ttZZZ4Pflw9CqkAuc5wxBKsobGO3LHxBteyPP1cbZUs/54Go+hyMkhSVbmGe2VCq/l3GBhfX25dgP2+tb1aGYvhm+pI/ZRhY/Rx7FUWb8ohn3Vd9Fm3NCSPzkBoL6IQm/rx0tUVArjiPM6ajIThMZn9BoB2GXHwDnqFY/paFNZD3UUPpdleqPaeJRVfMpQlVAR62qCsqXwQRtvoltYTG9RPe3swJGF3u3dn8V9C0s6rHGbZX4fFzLNfWO9TuH7Rg+uhNGmqLtcha8fbOTvjJOh6CqEaB0ZD+VZJulbrVRXxcb2USoDQcxB6RibEW29oUaPxnIuSri59kyChL/+tZDxYPCGBTDKB9tLGJ3yKG9SNwMQ9yprKvV8eGtJdQByee9SotUYOLC2SEkM8RboIR+IWSA3zKjItwDh6VgCtkrvIbhf9GIHaNN/Q82jzky0mucQ2Lr4fbFBgJFRnegj9TDUxKGVhfyvki+T3wAHOi7ROUSkMjb963wO9JJp5Z1627YeYOD4uJDSukHo6z0tmJxUVS8Iyk=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id y20-20020a056a00181400b006e06af90ff4sm9567294pfa.204.2024.02.14.10.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 10:51:35 -0800 (PST)
Date: Wed, 14 Feb 2024 10:51:34 -0800
From: Kees Cook <keescook@chromium.org>
To: Tycho Andersen <tycho@tycho.pizza>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Peng Zhang <zhangpeng.00@bytedance.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Mateusz Guzik <mjguzik@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Tycho Andersen <tandersen@netflix.com>,
	Mike Christie <michael.christie@oracle.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: Coverity: __do_sys_pidfd_send_signal(): UNINIT
Message-ID: <202402141051.5B17519F0@keescook>
References: <202402131559.B76A34B@keescook>
 <ZcwGua3a9Z8nJXVq@tycho.pizza>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcwGua3a9Z8nJXVq@tycho.pizza>

On Tue, Feb 13, 2024 at 05:18:01PM -0700, Tycho Andersen wrote:
> On Tue, Feb 13, 2024 at 03:59:37PM -0800, coverity-bot wrote:
> > Hello!
> > 
> > This is an experimental semi-automated report about issues detected by
> > Coverity from a scan of next-20240213 as part of the linux-next scan project:
> > https://scan.coverity.com/projects/linux-next-weekly-scan
> > 
> > You're getting this email because you were associated with the identified
> > lines of code (noted below) that were touched by commits:
> > 
> >   Sat Feb 10 22:37:25 2024 +0100
> >     3f643cd23510 ("pidfd: allow to override signal scope in pidfd_send_signal()")
> >   Sat Feb 10 22:37:23 2024 +0100
> >     81b9d8ac0640 ("pidfd: change pidfd_send_signal() to respect PIDFD_THREAD")
> > 
> > Coverity reported the following:
> > 
> > *** CID 1583637:    (UNINIT)
> > kernel/signal.c:3963 in __do_sys_pidfd_send_signal()
> > 3957     		/* Only allow sending arbitrary signals to yourself. */
> > 3958     		ret = -EPERM;
> > 3959     		if ((task_pid(current) != pid) &&
> > 3960     		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> > 3961     			goto err;
> > 3962     	} else {
> > vvv     CID 1583637:    (UNINIT)
> > vvv     Using uninitialized value "type" when calling "prepare_kill_siginfo".
> > 3963     		prepare_kill_siginfo(sig, &kinfo, type);
> > 3964     	}
> > 3965
> > 3966     	if (type == PIDTYPE_PGID)
> > 3967     		ret = kill_pgrp_info(sig, &kinfo, pid);
> > 3968     	else
> > kernel/signal.c:3966 in __do_sys_pidfd_send_signal()
> > 3960     		    (kinfo.si_code >= 0 || kinfo.si_code == SI_TKILL))
> > 3961     			goto err;
> > 3962     	} else {
> > 3963     		prepare_kill_siginfo(sig, &kinfo, type);
> > 3964     	}
> > 3965
> > vvv     CID 1583637:    (UNINIT)
> > vvv     Using uninitialized value "type".
> > 3966     	if (type == PIDTYPE_PGID)
> > 3967     		ret = kill_pgrp_info(sig, &kinfo, pid);
> > 3968     	else
> > 3969     		ret = kill_pid_info_type(sig, &kinfo, pid, type);
> > 3970     err:
> > 3971     	fdput(f);
> > 
> > If this is a false positive, please let us know so we can mark it as
> > such, or teach the Coverity rules to be smarter. If not, please make
> > sure fixes get into linux-next. :) For patches fixing this, please
> > include these lines (but double-check the "Fixes" first):
> 
> I think this is a false positive, we have:
> 
>         /* Enforce flags be set to 0 until we add an extension. */
>         if (flags & ~PIDFD_SEND_SIGNAL_FLAGS)
>                 return -EINVAL;
> 
>         /* Ensure that only a single signal scope determining flag is set. */
>         if (hweight32(flags & PIDFD_SEND_SIGNAL_FLAGS) > 1)
>                 return -EINVAL;

Ah yeah, coverity can't see through the hweight32 test. Sorry for the
noise!

-- 
Kees Cook

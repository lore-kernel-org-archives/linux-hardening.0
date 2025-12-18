Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 836E027A462
	for <linux-hardening@vger.kernel.org>; Thu, 18 Dec 2025 16:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075561; cv=none; b=apYRvYqCArve+P4p0A3+MNQ4wOYY7SpjraVWj+F/jsr7Aib8oUEjAxSR7ydg+Ip4BcKuS9uvoKl7aaPN9soijl++oNJjUAfuU+lyLG9q+cmh+gFdB8Sv/8NIWrP8TxSuIxCszCMtORXCDFINynWp7eRF87jJ5y+y7MLZyguSj9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075561; c=relaxed/simple;
	bh=SNnvyZ9vkTGATvlgI4Ih8b7/uG92hbaNc/B311zzepU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gR0pCM0u4A5useIFzS9o/kwKa8Ze8v2sN/KQrjGz7zCnDgqUx7Lttm2AebNBVj9R7C3xZUF8SmhKNElJ5GwqQctfyvyQzH6MfvpFXSq1WDrwVdoMvY2UgLVbyTuDqU0ZlL/Q/Do2Qkmza1qnp+KUu/u3+e0E5yvk+GRLUvubjH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=D782mtL/; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="D782mtL/"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-430f5ecaa08so418867f8f.3
        for <linux-hardening@vger.kernel.org>; Thu, 18 Dec 2025 08:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1766075558; x=1766680358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SNnvyZ9vkTGATvlgI4Ih8b7/uG92hbaNc/B311zzepU=;
        b=D782mtL/0ZUX8YYPZ1H1eLcMeww7bod9ij0QGI4iXtW+5WEPQSf+6rYFqSCD+Dy3We
         zn9SQ1X17Ho3YeOxa4eoLrhysiIkUvzunkQlvn8QxV7YoUaNtS0jZYH9R5SrSO5oUMPb
         x7+hiUSajTjs3vc6YM9MyAlNQY2UaEL5v8kV6XfCsZGUN8q1T1SQ8Tzn+8rZKylZbb7d
         ZMOieMRTNF4gdRDiJQN9uYOL9SViVY9Gt7eE/WpeA9f2ZQ43RXkeT3YlDvRLlwhOizdE
         EKXGpzoWEphNbfrWWJrY5mQFpLDfZi+ZvxZf1t0M42WwXzLIKElkx3ObQK8nsDY4FSnF
         8UQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766075558; x=1766680358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SNnvyZ9vkTGATvlgI4Ih8b7/uG92hbaNc/B311zzepU=;
        b=JK0Pr6bUH7iNhkBrATCfTkqrX2AeUvuVV3mLCTHcXgOGRiHNZHxw9X0kaq/O5cqenp
         S49Qg/VrVnnhL7MPmA5pSRONMxXySiff3vHUIlK7T1geKHTz6fPjncAtn3D/eXA+E910
         pHVfDZ9fhIG4JqRifVu5FUpEJP0oN+kNzaeT9XqFpK9Qv3gvrJg1HcUPiOFfITK1AwDW
         nevXlk3JGaTI3NSDjQa8wfBHCdESiHVhidi0fCDsJJBXtlBBBTQb6BQKl76/EPB8X5tv
         yVHAcwUkpEcmvxvfO1O3L5Nlsdi2p1HkGtdL0LyHRxLqe5mnHCrIfccqGpQSP0APDSUS
         aydw==
X-Forwarded-Encrypted: i=1; AJvYcCXdQBe/9OyqgAdFLfmOUaEs1u4tb56ikPyYCV/2OWdgR0ILMARXpTgUF2pwFOyZG4b9Q6jaIrFVQBCbwbaPy2E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfcDSxPZ2xq6dmo5t4a3LrIPXRlvcy+/jHWLmIVTUXkUH3tadE
	rYZmWkzOxA8GkeHpOQWyqIwZ0nULAfgFNTa0tRWlWKaOZtW3TYucteK8wCT+mZMtXJI=
X-Gm-Gg: AY/fxX6JjB4uJXBv3QX1l6NzJCU30x2nbrZfXy4eFoNklL/7ts/vGmhW2zAnOqh9FQd
	rV70fEsEMxH5eUegwBA/E9R6KnmFmCnMEiupDv6csP3QC7HlDy3ElilPBBNGUmhdmW3baebQrt5
	5rJG9bWL3tYuiL0FkzL/I4AopTkfnrTu0QlM172LM/49Gi6tM0KU4m5E2VGqO9I/p29FDFoVSqn
	G1cVj5HBLgDSw7ugrIqPUyCDzAGB0bdNwdeVaPlck8chNqZ8BqHhHmWkzTOtr4j4KFh2R+/ltMP
	DqBQ5YKJfSGFf1BHw5+tMpotKbInByahu7f1zfkH66T76E0jaDl7v/G603L18e6ZRwbrnQxQfdD
	JL1JDV8ZdCH6fCIWvzs+nw1i3htYv9g1CIH/ySNb7w7TzV0PaLnsDXo6TjfCbpaeefMCmtt2izz
	7u2I0trtCLPItyUzZYfjWwk1IsrKEjg+E=
X-Google-Smtp-Source: AGHT+IEDIDE4KTVKDsejMKejh4/aXt3graRane6v6z7goX6BJROYVpK3YamMTvz3oWiatc+Kg89G9w==
X-Received: by 2002:a05:6000:420c:b0:42f:9e75:8605 with SMTP id ffacd0b85a97d-4324e45d3efmr154078f8f.0.1766075557754;
        Thu, 18 Dec 2025 08:32:37 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432449adacesm5659879f8f.38.2025.12.18.08.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Dec 2025 08:32:37 -0800 (PST)
Date: Thu, 18 Dec 2025 17:32:35 +0100
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: Tejun Heo <tj@kernel.org>, 
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Chen Ridong <chenridong@huaweicloud.com>, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Johannes Weiner <hannes@cmpxchg.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
Message-ID: <ecrvq2zi3tyewmjis6wdwxsvzkosobzowrm4xoxzxq35hhobev@m6kroxwbnfa7>
References: <20251217162744.352391-1-mkoutny@suse.com>
 <20251217162744.352391-4-mkoutny@suse.com>
 <87cc0370-1924-4d33-bbf1-7fc2b03149e3@huaweicloud.com>
 <aUQnRqJsjh9p9Vhb@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wgk3s36crhaoc44i"
Content-Disposition: inline
In-Reply-To: <aUQnRqJsjh9p9Vhb@slm.duckdns.org>


--wgk3s36crhaoc44i
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 3/4] cgroup: Use __counted_by for cgroup::ancestors
MIME-Version: 1.0

On Thu, Dec 18, 2025 at 06:09:42AM -1000, Tejun Heo <tj@kernel.org> wrote:
> On Thu, Dec 18, 2025 at 03:09:32PM +0800, Chen Ridong wrote:
> > Note that this level may already be used in existing BPF programs (e.g.,
> > tools/testing/selftests/bpf/progs/task_ls_uptr.c). Do we need to consid=
er compatibility here?
>=20
> That's a good point.

I wouldn't be concerned about this particular aspect. The commit
e6ac2450d6dee ("bpf: Support bpf program calling kernel function")
excludes ABIs, the example program uses ksyms (not kfuncs), so there
could even apply Documentation/process/stable-api-nonsense.rst.
OTOH, the semantics of level is unchanged for BPF helpers (that are the
official API).


> Is __counted_by instrumentation tied to some compiler flag? If so,
> might as well make it an optional extra field specifically for the
> annotation rather than changing the meaning of an existing field.

Honestly, I can see benefit mainly in the first patch of the series
(posted the rest for discussion).

I'd like to ask Gustavo whether __counted_by here buys us anything or
whether it's more useful in other parts of kernel (e.g. flexible
allocations in networking code with outer sources of data).

Thanks,
Michal

--wgk3s36crhaoc44i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCaUQsoRsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIACgkQfj0C55Tb+AinigEAif7sDzj0YSa/E6aI3SHN
mYIMVmAgfmHtGztVSPBZk2sA/0ZdHU/Uf6jg2QruCsbrQ7Xq1DBM5nc6er4+hPGS
UhwN
=ZHnQ
-----END PGP SIGNATURE-----

--wgk3s36crhaoc44i--

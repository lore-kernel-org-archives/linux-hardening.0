Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6633D263C8F;
	Fri, 16 Jan 2026 00:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768522475; cv=none; b=CGT3adT8tqndZSbfXqE5GuO2ch+m/3zdKYoz4gdIZZ2Ie8oB3gDY2iQSDy5X1VIrixhX0jZdc6hAm+DzUzf+tScNtJkmhDwtQ4nUqjjIJDFBtP9w8q3hTe17cwhP8aIRgbMUWKwya+cs68eqjMZ3YP+c8v0sOT50j0zlGyQALDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768522475; c=relaxed/simple;
	bh=AJVJaIau4oUE8+USI5LB6aUb5QRcK7sa1qDRt8591bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJFbRHvCvuD/JPsC89tbbUmyzX+HH9lHjZDzYFw5d9UDb8YF2Z+OhAasdIdcX9lBsZKYN6FcXWU0BOyJMGB1VdBvklwnru9Elw/B8wkjuFDLbMq2+2ivbMJbHH9AG9fPZAraOcPoHq1cJFW2ikZhe9991Mq1ToNxFnYli2u3/4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHowNiP9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHowNiP9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C564AC116D0;
	Fri, 16 Jan 2026 00:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768522474;
	bh=AJVJaIau4oUE8+USI5LB6aUb5QRcK7sa1qDRt8591bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uHowNiP9qCHOA92hm4tcQ0MWft9mQiNxQYzPJtuz6EMr6Mmh+QbT5G/4ITxn83YSA
	 doR7AZWZyoyBxLar5gja86cWgGPjYsQNaevJt+7NeISlzc0GbkJpHY5HaCOe20ET5l
	 j32C7erP4BCTqQv48GtH34YP1TfT+KXQeLW6CsXZfAjTJubSNpwJPLbcVxiuVxSjQ+
	 ELxOBDYCK1ynyGJRNfEXBDGQ3AElOPYz56KKyQIiiGC1GcvagpTsNPq5LQyK7B1IAG
	 Dp8YfuwWw3hcUbJQN0ubNYQcOqxys7bLTBdrgBD/BrjhX3usMljh1CtJni7Cochle3
	 Mwn4xpKDO7+xg==
Date: Thu, 15 Jan 2026 16:14:34 -0800
From: Kees Cook <kees@kernel.org>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] drm/amd/pm: Avoid multiple
 -Wflex-array-member-not-at-end warnings
Message-ID: <202601151612.79AAC91869@keescook>
References: <Z678TNhCbTk363Tw@kspp>
 <864c7dd5-0deb-4adb-a1cf-c8a809514d7e@embeddedor.com>
 <217b00f5-d03d-4624-9ba9-d838199ef7b9@embeddedor.com>
 <CADnq5_M5Jv4A5CXAKY2Qd-dhrfmecnauRtVY_ghSsut7i=KNww@mail.gmail.com>
 <d07b4edc-6048-4c10-b8ac-dcccd5a932d3@embeddedor.com>
 <d43dac3e-122d-4c16-9c1e-760eac91b8da@embeddedor.com>
 <CADnq5_Mqa2HWWKrAYTAfjdvEQTMUeB1MBnhtRxJZjXLWcz1nmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADnq5_Mqa2HWWKrAYTAfjdvEQTMUeB1MBnhtRxJZjXLWcz1nmg@mail.gmail.com>

On Wed, Aug 13, 2025 at 08:57:58AM -0400, Alex Deucher wrote:
> On Wed, Aug 13, 2025 at 1:12 AM Gustavo A. R. Silva
> <gustavo@embeddedor.com> wrote:
> >
> > Hi!
> >
> > On 22/04/25 23:58, Gustavo A. R. Silva wrote:
> > >
> > >
> > > On 16/04/25 09:04, Alex Deucher wrote:
> > >> Can you resend, I can't seem to find the original emails.
> > >> Additionally, all of the NISLANDS structures are unused in amdgpu, so
> > >> those could be removed.
> >
> > I'm taking a look at this, and it seems that those NISLANDS structs are actually
> > needed in amdgpu code. For instance, `struct si_power_info` contains a member
> > of the type of `struct ni_power_info`, and this latter struct contains a
> > member of the type of `NISLANDS_SMC_STATETABLE`, thus `NISLANDS_SMC_SWSTATE`
> > and `NISLANDS_SMC_HW_PERFORMANCE_LEVEL` are needed, and so on.
> >
> > So, it seems that all those structs should stay. What do you think?
> 
> They are not used for programming the hardware.  They were just
> inherited from radeon.  All of the NI SMC stuff can be dropped.

(Looking through patchwork...)

It's not obvious for me how to drop that stuff. It seems pretty
integral? What's wanted here?

-- 
Kees Cook

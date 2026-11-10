Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794348368;
	b=vzRUOu4We/ftvio3VuHiWp8Qh0dG9B0cLWjGX5NEwxt95aPC1u+6XZ4z+iyT5qOYZWy7
	 LWRv+ewkb9rOGxdfMxkQefXJkMNa8zGlIKcGUFfJsqMJYKPb5eDa+bWLmz1SE6P7GKoiG
	 64Sa0pJnFFVQ+uutPVvHgvaEzKutWrSIQNb12lkC8CBJ1JiuRo+7zqBOgB/KRBDEu88Q3
	 QB7xIugEIPvGVOpuveK4d2Kp0CfFRJFCbR+OGl1fqKqM2errMlWiiXwtytYqs4Y2wodJO
	 Uj+e9dzhlaVFfLj9P+MpczTvyyiKQkMGtYjPAhfcqBWv7P6MX+MvQiUOjP0FJ6GF4NA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794348368;
	h=Received:DKIM-Signature:Date:From:List-Id:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Qz8TCCH079tK3dpdpnThhDt4myj5LiNs+u4plr9o/Qs=;
	b=wdvgGBOwbDq4VqeIqSj8FLYMFRtwEJ0O4Stk64MvU7Jw80GcM9x00fMJFwMGEBVvWgIW
	 w+gNHOzF3gOdJh67/TWOC3HGsFLNlhvfTKyq/c6GaYhtH1C52vypLxLkjPZygCwFTu1Yu
	 bV0qygAiLLVGoszGg1gPmTv7ltR3H1rYFYaVXAbwbdVHp5GHMCeZn3W/ZvrCAPal1GjBR
	 hPsglr3S7aShndk36EuCB96H3wS6u5Xh3sL/cIT4yz9G5FpiEgQ3r+DXStS82/bHnxe2a
	 7tkzySzUUSdD9ui+ErIDkIA06c1a9WcY99H01EVhVQ9wGZymwKiF04ZFtIcf071gUKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZPAK1Uv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7776C606A320;
	Tue, 10 Nov 2026 22:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JZPAK1Uv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488101F0089F;
	Tue, 10 Nov 2026 22:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794348368;
	bh=Qz8TCCH079tK3dpdpnThhDt4myj5LiNs+u4plr9o/Qs=;
	h=Date:From:List-Id:To:Cc:Subject:References:In-Reply-To;
	b=JZPAK1UvRqtBHvj/NtLGvLuDCfYo0+5EVe4d95MfnfGelZu6/WKkU3ZW2OtQ1QSJx
	 iIJAqDtKMKnOuW1ZLXHDdLDMRfnykG+F+9iMblCAyWnyReK0oh4ATnzZ3j4oYZcX+8
	 XCgWWc00cVFej2Qj0QQd15LMZ1C39iOWZzM/4lp8G4lDw28rc1c0v/6ZPImEsPt+sg
	 4Nfd0ES6sEBNjQri/CWUQr2FYE96p5KTqQIKtT8ccvqd8X30T62SY1v4vuLJAzhlS+
	 i6f8apayBBNcB7UR6JhpbPSmcis3Y+D0rdt6wlzCG5fDAhVwQtt4WnaF1aXF7DW759
	 2v2k6WFVRk1+Q==
Date: Tue, 10 Nov 2026 14:06:07 -0800
From: Kees Cook <kees@kernel.org>
To: Alejandro Colomar <alx+linux-hardening@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Alejandro Colomar <alx@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bill Wendling <morbo@google.com>, Petr Mladek <pmladek@suse.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuvam Pandey <shuvampandey1@gmail.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3] seq_buf: Mark a seq_buf overflowed when terminating
 it loses a byte
Message-ID: <20261110220602.272c5b-kees@kernel.org>
References: <20261104033110.out.418-kees@kernel.org>
 <ausTcdh966BNVA-_@devuan>
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Post: <mailto:linux-hardening@vger.kernel.org>
List-Help: <mailto:linux-hardening+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hardening+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ausTcdh966BNVA-_@devuan>

On Wed, Nov 04, 2026 at 12:17:00PM +0100, Alejandro Colomar wrote:
> > No current caller checks for overflow after terminating a seq_buf that
> > can be left exactly full, so none of them behaves differently.
>
> Okay for this patch, but still some question:
>
> Since data truncation is almost always wrong, is it a bug that those
> users are not verifying that no overflow happened?  Or do they have a
> good reason to not verify?

Right, this would need a case-by-case analysis. Some expect it and some
don't. This change to the API is to make it defensive in the general
case without making existing truncation worse.

-Kees

-- 
Kees Cook

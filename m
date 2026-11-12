Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515569;
	b=SuhUXT8Yz9Qi/I9xJLcR5PjU1wQhtzXoObtZa5o+yzhF4Zz0rATHen4PPYOWvABYd1fZ
	 qecZf2qlt8gLghtHcw7pbWyej+vJcdwzDYZfso/JWdLHDUsroou6Qt37lE0OZ8lf+en/h
	 pqb3XMJRPiswcGUyVd/svNQWxS4/lM8tpt+6RR+uXTtSsvoSauSl10d8yVajI/RP84+Ul
	 qOW0xcN90b/LPQG4coYSUz7YsIoR8qH2zmBKAbsSMv6jz0teFVvxsxOpP3TAfDsl1VvMP
	 DWq43FEotW2hXZzg4GrZD0TD5VVYbUnwtl+y5DLc0TnDErY9CFtx3lEbYYi/LIU/phw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515569;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=AsDn4YF/+HTUtS5asRLtQH9IQtupKKhhd90EY+I1wbw=;
	b=CEXTBAEpBjMJR8hhgzM1GRUpUhe94PQos88w4Cv879bF1v3paO339ZbgBUVJdPxDX0xu
	 UuWfCw59TPD+YaZvGLROEdtbKIsHpUkf4p2mcEbfrgIR7/nUT5yeEVefkTOHx8Is3/uap
	 FHxhOWSAeuE5I4lT5cDWW4Wgp9MxEiyHQBtvaVFW8Q2rCaLBcXICyMbM8YzL55HkWDD9T
	 lOe0eTD+/SkVlX52EPhMeJ0a65TL6MXOueKnkgc/Uf2xVf6pLQvH2uA+6qWSUD1W5WBRS
	 QWl1jZ+2/qYmUNYe+6XDgHe161qRU7US6YeGtk3xLmal36VPuVJvgxY8N0pLOifUeOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYMDP93k;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B77606A31C;
	Thu, 12 Nov 2026 20:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eYMDP93k
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7611F000C4;
	Thu, 12 Nov 2026 20:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515569;
	bh=AsDn4YF/+HTUtS5asRLtQH9IQtupKKhhd90EY+I1wbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eYMDP93koWyy/bnx/t+S0mi7oSlBuShcNN76TL6LVHpwbR1k51DE28dg4inwVIl0q
	 hm26eb7WPFydUtzDoM/EKEUQeAWsxI+aKU0qF44g5BqGM0U+UijCcvq8VTOlUAzguX
	 YFjCWRXQcD0iwfT10wPUWiJOL/Z9xVo89QfrPErjZ+3WdeapbfbCsLI//otlpJVPQg
	 SHHlh6pqahodo+lp7X9+exGhWWyk6TSsEadsrHDp5bUFJdidTjk35zR2d6RNyu9Y/S
	 tnHGUUOt1bm6y8aqhSqkofB+EXQABzWD2SGf0roo15ICi3z1LtaHc87bvqAxUAReF9
	 PmKvoBRjg8MTg==
Date: Thu, 12 Nov 2026 12:32:48 -0800
From: Kees Cook <kees@kernel.org>
To: Mariia Nikitash <nikitash.mariiaw@gmail.com>
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	morbo@google.com, justinstitt@google.com,
	codemender-patching+linux@google.com
Subject: Re: [PATCH] comedi: comedi_bond: Refactor strlcat() to seq_buf in
 do_dev_config()
Message-ID: <202611121231.A1A73DF@keescook>
References: <20260927060000.518354-1-nikitash.mariiaw@gmail.com>
 <202611121039.836B308B1@keescook>
 <CAPDEY+UbZ_VdJQR3n_nf2M4e5dVEQA5wVDTPbPE-T3ckP6H1OA@mail.gmail.com>
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
In-Reply-To: <CAPDEY+UbZ_VdJQR3n_nf2M4e5dVEQA5wVDTPbPE-T3ckP6H1OA@mail.gmail.com>

On Thu, Nov 12, 2026 at 12:16:11PM -0800, Mariia Nikitash wrote:
> Thanks for the review! This patch has already been merged, but I'd be
> happy to send a follow up patch with seq_buf_terminate() if you'd
> like.

Nah, it's fine. :) I don't see value in the churn since the binary
output will be identical.

-- 
Kees Cook

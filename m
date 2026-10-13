Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770C03859E2;
	Tue, 13 Oct 2026 08:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791878853; cv=none; b=GVDSwgkSmLVSw0Wb/rNamLQQDM9iWSMdEe/ydtznvUHy/ITAsvPIfhnkCJYOpLswPfFSeVrqfsK/UR6BQZZxUxZ/0XLiaK/U4Tsa+Wvtixmtx1/ZRNWZVxPmFWGFezGMJpvBW//D89kyIrfn90hoygl0e2X9RzYifYOKu+f2+/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791878853; c=relaxed/simple;
	bh=5TlFjL4l38jNXUi6seND/H9B2myRsoM0WqHa6aOoHXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D6lshIXKNiS4ZntPXEvbqKpSFWx5Ix0rO4Uy+70Y+KOY6M8SrVzIGb4wTiw6pt3/2H+GG1N8W0bX3/h2Oh6rilsGcVulqmGWiSKSc7n8Ug7kQJ253v7cHsXEV3B/ZY2QMJQK+nKrg+aLh1PQCSK9NoPvBDmzOcec11h00w+Y9+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fxbES/Fv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxbES/Fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C101F000FF;
	Tue, 13 Oct 2026 08:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791878852;
	bh=yllcDk776GPbP0ij4HCD8TWUc0JMOURL0NPZdNz4x2s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fxbES/FvTcomN2aDAS4IkZPlhR1b7x/6uu7H6nzhz6N5EToQk0JLc1OJpmvrgHvkb
	 PxqdddBzvj5KW0Uxd7yssML+laiaDZBvAiWTq1FiHr8vZrvBtZPuA8UH0etdufNCm6
	 FfW/5bRI8jRpA+TvlDJhSjwVh1+VjewmXrcLEpzHVQdACQ9irZe4y+VL8FRGcvkdPB
	 N2VYhugKQjaHnArZwV7p31bp02PJzj8vcuU2FuXcudU/Zd4YVhTIt5lfDSnWZV8dsc
	 Wcu1Ghtdkm20KFZ2yUCjz9vw1iHKh8VpGc4aXogwDfWsx/LmjsZ8vAHJw9Ysnafygg
	 AIWegIL3c+h1Q==
Date: Tue, 13 Oct 2026 01:07:31 -0700
From: Kees Cook <kees@kernel.org>
To: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: peterz@infradead.org, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, justinstitt@google.com,
	linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, mingo@redhat.com, morbo@google.com,
	nathan@kernel.org, ndesaulniers@google.com, samitolvanen@google.com,
	tglx@kernel.org, x86@kernel.org
Subject: Re: [PATCH 2/3] x86/kcfi: Emit the FineIBT paranoid "cs" prefix as a
 byte
Message-ID: <202610130106.5CF1301D@keescook>
References: <20261012091601.GN4121339@noisy.programming.kicks-ass.net>
 <8aae2418-38e1-479a-bf82-df65acde0ffd@citrix.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8aae2418-38e1-479a-bf82-df65acde0ffd@citrix.com>

On Mon, Oct 12, 2026 at 08:05:21PM +0100, Andrew Cooper wrote:
> > On Mon, Oct 12, 2026 at 02:04:25AM -0700, Kees Cook wrote:
> >> The "cs" prefix on the LEA in the FineIBT paranoid caller template is
> >> padding: it places the LEA's 0xf0 immediate byte where it doubles as the
> >> LOCK prefix that makes the failing Jcc raise #UD. GNU as warns about it
> >> in every CONFIG_FINEIBT=y build:
> >>
> >>   Warning: segment override on `lea' is ineffectual
> > Shees...
> 
> This is a binutils bug.  Can't we fix it here?

I can try to send a binutils bug fix?

> The claim in the warning is simply not true.  This is an example where
> it absolutely does matter, and it also matters for legibility that we
> can avoid writing raw hex.

Well, we'd have to keep some kind of work-around for earlier binutils
for a long while...

-- 
Kees Cook

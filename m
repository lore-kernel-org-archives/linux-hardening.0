Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09FB9297A62
	for <linux-hardening@vger.kernel.org>; Fri, 23 May 2025 14:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748010318; cv=none; b=Wfme7Vi0Ekp94pj3TIf+Rl7NQGFQway1stfsYlGXKCeJVXo6cW0q28he44mBO5UYzEo9eS4AhFwqeghtXNIt+mv3r73eg5Jq7ZijRrDVChlnP9SSWXC4J1xji8LCThonuCTsui20k2j/lY5hBwWsLScKz71m5GNaN99K2A3IHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748010318; c=relaxed/simple;
	bh=Jr92kqhLnQvRNC5L+L0W3yvG7mH4cdCdsfVACqlC638=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea3ix0EaOdswMPJ3pBUNBGJFLw0c6pA6f8Dz0NrgcnXrUnm0f8PXO5eqwJmNSwKxPNMA7NtScNVvEFBWU9MEHUDGEu89ITvXmhZMo+8enxAmWs/UNmZ8iyNBUgzrsesfwv8cjJkKa9bIikJaNWNZrxBpyov5/GwArZKiq/rcCvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-173.bstnma.fios.verizon.net [173.48.111.173])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 54NEOnpP028475
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 May 2025 10:24:50 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id 81E5F2E00DD; Fri, 23 May 2025 10:24:49 -0400 (EDT)
Date: Fri, 23 May 2025 10:24:49 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Laight <david.laight.linux@gmail.com>
Cc: Kees Cook <kees@kernel.org>,
        Ethan Carter Edwards <ethan@ethancedwards.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2] ext4: replace strcpy() with '.' assignment
Message-ID: <20250523142449.GB1414791@mit.edu>
References: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
 <202505190651.943F729@keescook>
 <20250519145930.GB38098@mit.edu>
 <20250523133100.1b023a6e@pumpkin>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523133100.1b023a6e@pumpkin>

On Fri, May 23, 2025 at 01:31:00PM +0100, David Laight wrote:
> 
> The compiler (or headers files) can also allow strcpy() of constant
> length strings into arrays (known size). Erroring requests that are too long.
> The strcpy() is then converted to a memcpy() which can then be optimised
> into writes of constants.
> 
> So using strcpy() under those conditions 'isn't all bad' and can generate
> better (and less bug prone) code than trying to hand-optimise it.
> 
> So even through strcpy() is usually a bad idea, there is not need to
> remove the calls that the compiler can validate as safe.

I assume that what the hardening folks want to do is to assert that
strcpy is always evil(tm) so they can detect potential security bugs
by doing "git grep strcpy".

						- Ted

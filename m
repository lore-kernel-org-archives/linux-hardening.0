Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2FD1DF26A
	for <linux-hardening@vger.kernel.org>; Tue, 14 Oct 2025 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760484734; cv=none; b=r/zYG9KckzmWM93hLhasWXpMKKBYUzQAuynoNlJmELBQKLvRg/53TzWSsWuje1utUmfBb+lphgcVBkUv3k7DOAeVjPzegL94Vc/qVSOmcGxQsThoTQ2PyoQqFOdUJqSXTqszpK69raZVmlUm4ftFZ55bQ3Dz9k6m4O04XPhH3oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760484734; c=relaxed/simple;
	bh=eey9cgRoxjE0i/IfOZEja1nNQCnPPMVaDTTgVcD6Kf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fL1D5RPiEncTjXtvvzn0WPE/tqRpjilXiSOD+oHKty/bVIFEqaVNApv1xiUtrcfMkAbBliOgI2mkIazlFZfsRJMFQnoVJvkqs/GJRbxkUkuBdMofjXLySgBSWVjcdK5Lim0eDHyvm5NUN6CTJPBNGTTdCviHWpC7ADZ+tR1LB4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G84QffJ1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G84QffJ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95122C4CEF1;
	Tue, 14 Oct 2025 23:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760484733;
	bh=eey9cgRoxjE0i/IfOZEja1nNQCnPPMVaDTTgVcD6Kf8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=G84QffJ1CojC82iGJFDNiM4zGwyHjbWYDQakBVamkfNbAbOxZxBREK2aaAvC0gYw3
	 GYpd2QSj0rmyLY9Nf0I+T5Iq7olUht7XC6OqQhqkgWO2HNAZfFWAtyPp5Ei/lWZthl
	 0qETKEwzq9ZbmsPzPLl67PW2rH5KZyOVqICrKM6ybXx9H7AwezMuB9e6p+7xLiGyqa
	 S+k0PilRYbNYEPlJKvHU5ou6JVhjxJitkymeC5SdVRNRIl5YJVM3YDEi+j4QzxSMAr
	 xSA92C1EHtZgm69gk3iuz/yLrkE69VXKEZ6kQMDKXqK03Irzh2oIwBCnG3lcezSkNK
	 30pFv3nQI2q0g==
Date: Tue, 14 Oct 2025 16:32:13 -0700
From: Kees Cook <kees@kernel.org>
To: Qing Zhao <qing.zhao@oracle.com>
Cc: Andrew Pinski <pinskia@gmail.com>, Jakub Jelinek <jakub@redhat.com>,
	Martin Uecker <uecker@tugraz.at>,
	Richard Biener <rguenther@suse.de>,
	Joseph Myers <josmyers@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>, Jeff Law <jeffreyalaw@gmail.com>,
	Jan Hubicka <hubicka@ucw.cz>,
	Richard Earnshaw <richard.earnshaw@arm.com>,
	Richard Sandiford <richard.sandiford@arm.com>,
	Marcus Shawcroft <marcus.shawcroft@arm.com>,
	Kyrylo Tkachov <kyrylo.tkachov@arm.com>,
	Kito Cheng <kito.cheng@gmail.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Andrew Waterman <andrew@sifive.com>,
	Jim Wilson <jim.wilson.gcc@gmail.com>,
	Dan Li <ashimida.1990@gmail.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ramon de C Valle <rcvalle@google.com>,
	Joao Moreira <joao@overdrivepizza.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Bill Wendling <morbo@google.com>,
	"gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
	"linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 1/7] typeinfo: Introduce KCFI typeinfo mangling API
Message-ID: <202510141631.812788BFB@keescook>
References: <20250926023737.it.616-kees@kernel.org>
 <20250926030252.2387681-1-kees@kernel.org>
 <139753DF-8174-45D6-B5E7-DFA65D380BD2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <139753DF-8174-45D6-B5E7-DFA65D380BD2@oracle.com>

On Fri, Oct 03, 2025 at 07:21:22PM +0000, Qing Zhao wrote:
> > On Sep 25, 2025, at 23:02, Kees Cook <kees@kernel.org> wrote:
> > [...]
> > +/* Helper to update FNV-1a hash with a single character.  */
> 
> All the comments of the functions in this file need explanation of the parameters. 

Whoops! Yes, I will fix that. Thanks!

-Kees

-- 
Kees Cook

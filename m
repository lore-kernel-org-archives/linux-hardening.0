Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 206D528136F;
	Tue,  2 Dec 2025 16:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764694748; cv=none; b=Fnu3gjkJ3YnFABITHkY9N8aCkD71SPHKEcProkrD1br0Fa/Xm3RBQKIkMpAxuJMI9ZT7VrpNGubn8vvm1HRRtJh40DgZemeZDjCC6M0rKeWGTioZmf6CQh3OnO2V8BMvXanrmeyIMAGBqoSy15kEyOSL2T1kyG18n3YJ0EIght4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764694748; c=relaxed/simple;
	bh=BKuRmo/5X5VVzMCwr0RNY84CwTP4HWe2icEbznJHVzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRJEsF953AUgp9jJeOcK47YBH4QLzg4s2cleAwt2Jzq12r/Vu7Xe9h9iofwEvBufj3IV9ALlr2sHGQychqix/MGxMJnepgZs3vGD/13u01DJ2U4kWbnK/6NoXpFIMraS9BSZcac+ekhhoj4bK5Et7eRtvMYakg5JzaQG3sqzE7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKAi/mUA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKAi/mUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA00C4CEF1;
	Tue,  2 Dec 2025 16:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764694747;
	bh=BKuRmo/5X5VVzMCwr0RNY84CwTP4HWe2icEbznJHVzc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKAi/mUAqSC/tVRSdbcmC8qjlezFOCw66U60BYYB54O8IHOMfIELqMmRm/3DgO30N
	 jXu7BmHni2QysJ+encGdMUd2U11R5r2u7gCtWvZBBzjDO//T/zVij8Cnpha6MQ1fhJ
	 zbkJf8+kEILwxG3D1lWhiIXXYOiIkix7mbCFNlGSfG5lCJqTf01zSQrJt5CW27paFu
	 mYwt3ztzKiaKc+3bttfcOz9B3Bv8xA5W0s3HlITnSCpgjtymU3btwcrQq+BPLek8jA
	 jlaKIRNXFH2V0mEITs0MuHOLE92cvn39QfC22BSjE/rbB00WQXapE642ZijCDvfOsX
	 9Jv1TTBTDbjxg==
Date: Tue, 2 Dec 2025 08:59:07 -0800
From: Kees Cook <kees@kernel.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Ard Biesheuvel <ardb+git@google.com>, Will Deacon <will@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Jeremy Linton <jeremy.linton@arm.com>,
	Catalin Marinas <Catalin.Marinas@arm.com>,
	Mark Rutland <mark.rutland@arm.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	linux-hardening@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/2] Fix bugs and performance of kstack offset
 randomisation
Message-ID: <202512020858.8BD22F486@keescook>
References: <20251127105958.2427758-1-ryan.roberts@arm.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127105958.2427758-1-ryan.roberts@arm.com>

On Thu, Nov 27, 2025 at 10:59:54AM +0000, Ryan Roberts wrote:
> As I reported at [1], kstack offset randomisation suffers from a couple of bugs
> and, on arm64 at least, the performance is poor. This series attempts to fix
> both; patch 1 provides back-portable fixes for the functional bugs. Patch 2
> proposes a performance improvement approach.

Just to chime in -- this looks really good to me! Universally improved
performance, reduced complexity, and better randomness. :) I'm looking
forward to v2!

-Kees

-- 
Kees Cook

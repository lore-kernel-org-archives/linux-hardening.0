Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26D828B7F0;
	Wed,  7 May 2025 15:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746633035; cv=none; b=YJ8dhi/JKLw7PhBJlIXhKE0HfNpoPj1J3r/bFDxn20cALCQAdEeZNaznMfGEMZb3XDduRtW9owuSPbPRs/HJrzuNdlNafjF8hrfPMNyfWxsv2dtBKo4UQYZ6/pU0mqJjjQBYNSpa8g94NC41JN83v6+meNNV53ZV65HAQaezFjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746633035; c=relaxed/simple;
	bh=/kk+lMEV9goTpRWvoLzP681rFcpsKOtwSv5IQnnAQ4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o325qYw9GMKPl1Hm7Fhj1cBRJiVQTs1TdxNXsNjeaNxZaeRn5xYOmpxCWEu2YFF7xEQ7nj8t1l0dSDdQ/IsgxTja94xoIAjA+ntEtsPEjmB7T4j0CKneDHjQ58IAsw7/PEsr6dkorv+8FXzylQ4yzHHBiiQ2OMgsQa4gffZCPfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S8kuPuDd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S8kuPuDd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE80C4CEE2;
	Wed,  7 May 2025 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746633035;
	bh=/kk+lMEV9goTpRWvoLzP681rFcpsKOtwSv5IQnnAQ4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S8kuPuDd6TlAsDYR9wp/41rHJDkWTwCjPWtbetr2wt+mtHbzmWO/O4YbNXWmOnPuK
	 lPI7BM5lKG4tmZknGtWx0DzN8j237oovyYxK0eSY8vBLn2C8rlaxK19nGqeFknm4Mp
	 GVemygZS90+SZg7Xn4cMcGikJAogcL8d/QwCs3xpxdecblPyxjSmRbvKKVKiXM/1z6
	 7Z/GpR6USHjgbaPQ8HuxmfroCUndcgyygAi/5bFQn3XOnhUwyeuJgC83MS7g8pHiYw
	 ozqpF0hwkJaLjtFMiH6c7CKqWRMyZ2JHtQ3O+2OWictKYYePBibZE2bY1aj6r5g7CJ
	 GeU3GNh+GbKdw==
Date: Wed, 7 May 2025 17:50:32 +0200
From: Andi Shyti <andi.shyti@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Matt Roper <matthew.d.roper@intel.com>, 
	Gustavo Sousa <gustavo.sousa@intel.com>, Andi Shyti <andi.shyti@linux.intel.com>, 
	Lucas De Marchi <lucas.demarchi@intel.com>, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	Gnattu OC <gnattuoc@me.com>, Nitin Gote <nitin.r.gote@intel.com>, 
	Ranu Maurya <ranu.maurya@intel.com>, Ville =?utf-8?B?U3lyasOkbMOk?= <ville.syrjala@linux.intel.com>, 
	Angus Chen <angus.chen@intel.com>, Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>, 
	Yu Jiaoliang <yujiaoliang@vivo.com>, Dnyaneshwar Bhadane <dnyaneshwar.bhadane@intel.com>, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] drm/i915/gt: Remove const from struct i915_wa list
 allocation
Message-ID: <e4rgvbw3ts7bnj2opz44exharx2ybxvjzzwu3kzthnc5i2a37u@fzswrwnjggqd>
References: <20250426061357.work.749-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250426061357.work.749-kees@kernel.org>

Hi Kees,

On Fri, Apr 25, 2025 at 11:13:58PM -0700, Kees Cook wrote:
> In preparation for making the kmalloc family of allocators type aware,
> we need to make sure that the returned type from the allocation matches
> the type of the variable being assigned. (Before, the allocator would
> always return "void *", which can be implicitly cast to any pointer type.)
> 
> The assigned type is "struct i915_wa *". The returned type, while
> technically matching, will be const qualified. As there is no general
> way to remove const qualifiers, adjust the allocation type to match
> the assignment.
> 
> Signed-off-by: Kees Cook <kees@kernel.org>

merged to drm-intel-gt-next.

Thanks,
Andi

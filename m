Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D8B1BC5C;
	Tue,  7 Jan 2025 00:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736209650; cv=none; b=DUQXuxCK1Tl318xCVkRJBY6bzV20W2ZMiZ6BEdpcaW8+FR4I8QGMitPVdLnTvz8TxOXWAjH+dJO7YEJcXjRIodp9lGC0UcJkkGPCLVLqittxIA1axdXdOcsUlVy8uMNWbOBC3w6h3yWs75deV97RSiWigYpqofMYyZyhyIliyfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736209650; c=relaxed/simple;
	bh=t4F/7yV0zZZOGlly5bLDfhSxyJEKZxc7aEoVRHcTuvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T4ZXoAz7/jnM4Frbs58x2T+5mi5G4qdBTqIBj1XgtHufMv+wkstXWjkCRJyu2LJwcdr8Dj3NaK/6+TZdlxgqS8tTz7YGav0+I7y1lScLJrhdMZ0FKG9SngC8BdR1URXAgmmwwnutVRCQOSU24LGIWAHGc5h4IL9UN6NmdHdZ378=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCY78VhC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCY78VhC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9174C4CED2;
	Tue,  7 Jan 2025 00:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736209649;
	bh=t4F/7yV0zZZOGlly5bLDfhSxyJEKZxc7aEoVRHcTuvI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SCY78VhC5sSw9yB37h/66Scne+hmZTUCUEsPr3GJotkAdQdyhkc3iA2imVyMZR/C1
	 ZxIzWoeW78Gy3aRcawR93ZzF+Ny+fCExou0Z7UA74pxMac0qtguWWLOjEKzuSMgEOT
	 hk0Hcsxr4ck65UzK1vLCELyu/r+JdNjthL3IEUjRCTkMe9l3mnE74PEmotHonQBhrw
	 8hfzamRfyJtLqf1ktYYt90N6eqQXwpDKRbzp9DNnqGTLxcVC1KEHkiYswQk5G7hln2
	 ZKTnbpjqyPtqEFvXSc4LzXeh3c3yFHgGBF287Ecvu2kONF/oYGgiEQOwVmehN4bhj8
	 lJfZQ5dDimmNg==
Date: Mon, 6 Jan 2025 16:27:26 -0800
From: Kees Cook <kees@kernel.org>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-hardening@vger.kernel.org, kernel test robot <lkp@intel.com>,
	oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
	James Morris <jamorris@linux.microsoft.com>,
	Jann Horn <jannh@google.com>
Subject: Re: security/landlock/ruleset.c:96:9: warning: 'memcpy' accessing
 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset
 -2147483648
Message-ID: <202501061623.7A617B09@keescook>
References: <202501040747.S3LYfvYq-lkp@intel.com>
 <20250106.uu8as0Ha6pof@digikod.net>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250106.uu8as0Ha6pof@digikod.net>

On Mon, Jan 06, 2025 at 06:04:56PM +0100, Mickaël Salaün wrote:
> On Sat, Jan 04, 2025 at 07:26:27AM +0800, kernel test robot wrote:
> >    security/landlock/ruleset.c: In function 'create_rule':
> > >> security/landlock/ruleset.c:96:9: warning: 'memcpy' accessing 4294967295 bytes at offsets 20 and 0 overlaps 6442450943 bytes at offset -2147483648 [-Wrestrict]
> >       96 |         memcpy(new_rule->layers, layers,
> >          |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >       97 |                         flex_array_size(new_rule, layers, num_layers));
> >          |                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> I guess the GCC warning is a false positive?
> See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=116494

Does the warning go away if flex_array_size() is open-coded or if the
create_rule prototype uses "*" instead of "[]" syntax for the "layers"
argument?

The warning is about the "read" part ("accessing"). Using tip-of-tree
gcc with -fdiagnostics-details might show more details on the calling
path.

-Kees

-- 
Kees Cook

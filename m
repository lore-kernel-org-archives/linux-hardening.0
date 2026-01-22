Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7E0285404
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769090971; cv=none; b=QNfxx4EAkxdtv2FTGalt24AdZz4uLIDUXv3b6Y7M+Yja0DnKtjakA9eJXgQV/FqbhmSxe/6i2/WPlL/gXCCTAEK6vNdEsqjD3a9fS8yxCCiHbDz8R7r2X3IcsVHofcqnDSXTIxqh2iLXcrR6Zb525O9fLVjpjN4hY1F1OPbPnz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769090971; c=relaxed/simple;
	bh=RCLGC7IWjlnzFdEPL6FQfd1D4OQ2kl6RQn1ANWWqhoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8z9IylKEm8mnjiNNEUA72578jmer4whK0awiTcBV/OrEPCbX0SrJN/5XVxu2EPfLfpXx8K3UjPf1AspC+NPjcEhvcSaGRPHb7bi+gLNSh6NXAe5EinCi3n0Y9kSdXQqZ0VMRa/qwIloXBJdhGp9UhCd0VdfQf+P5QHxAMu1pis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdwUwfhm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdwUwfhm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3269BC2BCAF
	for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 14:09:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769090971;
	bh=RCLGC7IWjlnzFdEPL6FQfd1D4OQ2kl6RQn1ANWWqhoE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fdwUwfhmSO5xDqUtMdzjkyrNw3KQ3GQuZBJT4l4mXrmYXZDkGg7ggzt/6hiu9RoOE
	 8aaAGi8wT+WO4uoYOvTKLmBTCsRABQ+dayR0N0Y6QF8JTw2efv2bfCLN5PCW0iulI6
	 o/4q3WqtZRgu3yUzVWZfrZPXwco4nYN5JN+5HKRy35Xm0vROD2xOTGxvpeLx/zFJ2/
	 w0M876L2wERmcPnusUbMrqOsKKPhZVOVwwxTCJUmTJEjlWVvTkMU5lq4r+8daiSBrm
	 aLQ2u1k7gXak0h7B6m9KNMnayNDzwE7eTHAjF/gIOVjmQ4CxuYhqZdDIqAZzICMZgI
	 5epEoOuZGIiSw==
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2a77c1d5c3bso4649505ad.0
        for <linux-hardening@vger.kernel.org>; Thu, 22 Jan 2026 06:09:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCURtoh8D+/np5xTTpMr6E9MJzJX4OBXbWcREEEiAmUV/Q8fkp6cDkFX5MlcFRaRpPLnposgNjwK6v6SiTu/UpI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9LuT8HhsQ8tI7qrjUWA7bntkm9l0E+G0EsbQrKIyXKLEEQ7oV
	eezwvPvaYDqgPZJwQiqPZbVLy7WR8bBsZj42kAg8XHCENSFl6Y0HVTWUYe7y83lgVzkoAuySrK3
	rxYUUF39nYBcGobRoA/6N0q6Oh4Q98Ds=
X-Received: by 2002:a17:903:2acc:b0:2a7:ca82:c198 with SMTP id
 d9443c01a7336-2a7ca82c35bmr39096195ad.6.1769090970754; Thu, 22 Jan 2026
 06:09:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108092526.28586-21-ardb@kernel.org> <20260108092526.28586-22-ardb@kernel.org>
 <20260122130839.GFaXIhV9SPFzS-RDnj@fat_crate.local> <CAMj1kXFK-Xf73wHDnidhDdMpb=UrWaf3vQhnggmNqOJspKYqvg@mail.gmail.com>
 <20260122135831.GCaXItB6KFO_HRqGcD@fat_crate.local>
In-Reply-To: <20260122135831.GCaXItB6KFO_HRqGcD@fat_crate.local>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 22 Jan 2026 15:09:19 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEVEbZGaVKdLp-95ffFv_cy181sB791LJYptkL+ap3VhQ@mail.gmail.com>
X-Gm-Features: AZwV_QgsOh_USPNyuaPUm4Y7_ETQYdAw4YK3SREaCTuxBkd9m230eo2D59GcrIE
Message-ID: <CAMj1kXEVEbZGaVKdLp-95ffFv_cy181sB791LJYptkL+ap3VhQ@mail.gmail.com>
Subject: Re: [RFC/RFT PATCH 01/19] x86/idt: Move idt_table to __ro_after_init section
To: Borislav Petkov <bp@alien8.de>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Kees Cook <kees@kernel.org>, 
	Uros Bizjak <ubizjak@gmail.com>, Brian Gerst <brgerst@gmail.com>, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Jan 2026 at 14:58, Borislav Petkov <bp@alien8.de> wrote:
>
> On Thu, Jan 22, 2026 at 02:48:14PM +0100, Ard Biesheuvel wrote:
> > That is because the init region is between .data and .bss, which are
> > not 2M aligned, and so freeing/remapping the init region breaks the
> > hugepage mapping of the region between them. This is addressed in
> > patch #3.
>
> Ok, I'll continue looking but this commit message should not mislead in
> stating that it prevents the "breaking up large page mappings."

It does. It just doesn't prevent if from happening for other reasons.

> I'll fix it up
> if I end up picking up this or you fix it up in your next revision please.
>

Ack.

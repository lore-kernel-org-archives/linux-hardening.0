Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2430513BAD5;
	Tue, 23 Jul 2024 23:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721777726; cv=none; b=aOJNrNe12QTHsn/IT4TDE4uhOPO8SJydJnFg374vABRKuAxbpaW8Mg1KuWiudtH0uEXIeCrTyNpUpBxG982D0HsbCX6F+6O//aqb/yccZf93DelBU1NyWLIH1hwEx+S74VE5/64uV2geBQGIOfQGsDSyJFAD7T+y3PlQb3Clkto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721777726; c=relaxed/simple;
	bh=1rSpXZ3AqEfIYdGrjK+41z9CVgtkIlPSRMhRWc9Xk20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rnC0kZvYe3XYWrbr3/F43jdCaUi5sHzF6ik8XOBuGfq0bj+rGm7l3zAPowVd87TzmKmcnfjWXGExg5NmvLAywkuGFMFm6Uz3m3C2KeCbsV2i5ACg2/ro/bwwos+8bb9jLt0npl4WpAiftpEc5867LlSp3/vYIL8xgqqzgP70Q2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIKZAgGs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIKZAgGs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CD39C4AF0A;
	Tue, 23 Jul 2024 23:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721777725;
	bh=1rSpXZ3AqEfIYdGrjK+41z9CVgtkIlPSRMhRWc9Xk20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pIKZAgGsGgTT1B3/G8OtJV5i8DU1NFtQj/YbSBVaYj7U4c6IBGDmUrS8sYmoOBi0u
	 V8R4MxwIi/shEpCcPzWL63cVKkx8eg/Z4iGX5iuzSlV21kw7YDaJCaEc2m+ggH7YtD
	 +189f8Fgt/j2NcJCgLed2j2U8HssLWhAgW45WowOy0cu0uvhzvXADZTDU8IFPG6Wof
	 9dHqxqwkvAfSv30IouputiMgt9VLEfx5b5qLUwr0FcG63xPhQ95rTEw0Zx7mZoNVMk
	 18q3aog4SLIqNLB1VQupV9wfdPHHDWBPvkKnYpoL7ZD3h5g/74KQ1CFZcOSs6Ey8yz
	 sDsvFPmefLX2g==
Date: Tue, 23 Jul 2024 16:35:24 -0700
From: Kees Cook <kees@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Andrey Konovalov <andreyknvl@gmail.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Erhard Furtner <erhard_f@mailbox.org>,
	Nico Pache <npache@redhat.com>, Marco Elver <elver@google.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Daniel Axtens <dja@axtens.net>, Dmitry Vyukov <dvyukov@google.com>,
	linux-hardening@vger.kernel.org
Subject: Re: [linus:master] [kasan, fortify]  2e577732e8:
 BUG:KASAN:global-out-of-bounds_in_usb_copy_descriptors
Message-ID: <202407231617.FEB5AC3@keescook>
References: <202407231547.389c0ad2-oliver.sang@intel.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407231547.389c0ad2-oliver.sang@intel.com>

On Tue, Jul 23, 2024 at 04:51:36PM +0800, kernel test robot wrote:
> [   25.775287][    T1] BUG: KASAN: global-out-of-bounds in usb_copy_descriptors+0x15f/0x370
> [   25.776048][    T1] Read of size 192 at addr ffffffff90c3e4c0 by task swapper/0/1
> ...
> [   25.777833][    T1]  __asan_memcpy+0x1f/0x60
> [   25.777833][    T1]  usb_copy_descriptors+0x15f/0x370
> [   25.777833][    T1]  usb_assign_descriptors+0xad/0x410
> [   25.777833][    T1]  f_audio_bind+0xe25/0x24f0
> [   25.785907][    T1]  usb_add_function+0x192/0x4e0
> [   25.785907][    T1]  audio_do_config+0xf9/0x160
> [   25.785907][    T1]  usb_add_config+0x38/0x460

The memcpy is:

usb_copy_descriptors(struct usb_descriptor_header **src)
	...
                memcpy(mem, *src, (*src)->bLength);

I can't find a bLength for a struct usb_descriptor_header::bLength that is 192...

...
audio_do_config()
  usb_add_function()
    function->bind(config, function);
      gadget/legacy/audio.c:audio_bind()
        usb_add_config()
          audio_do_config()
            usb_add_function()
              function->bind(config, function);
                f_audio_bind()
                  usb_assign_descriptors()
                    usb_copy_descriptors()

Is this thing in a loop?

-- 
Kees Cook

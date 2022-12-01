Return-Path: <linux-hardening-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31860C4321E
	for <linux-hardening@archiver.kernel.org>; Thu,  1 Dec 2022 21:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiLAVOd (ORCPT
        <rfc822;linux-hardening@archiver.kernel.org>);
        Thu, 1 Dec 2022 16:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiLAVOc (ORCPT
        <rfc822;linux-hardening@vger.kernel.org>);
        Thu, 1 Dec 2022 16:14:32 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D153BF66E
        for <linux-hardening@vger.kernel.org>; Thu,  1 Dec 2022 13:14:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669929271; x=1701465271;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rGV9/sGB5NA5ei2xfzI/Xf9HZin/s7i+I+92rYOoLQE=;
  b=HrFNR+75Gscr71FsEzGXSdxKjomnDt7iToiZBbAmUlAuzuue/vzMkC4q
   JPSXcVXeTgu/cGsepAbEfi9HiSJkh+ZhC5BUV7xPxuLhR2JFgTO/98dns
   ie0LStkUV3DKLfXRsp5Pp0+H/G9Ov+vXOIFh8ycfYxCNgGSnn94g2fg0R
   LkRXaKIgazgd/ggipLQThcbwO0P5rjT31ous0NNIXE3Md7HhxKCjyH31j
   AG+vwl6xZ/DnyMgTUZ/7aiI9uvHln994oPDsxIR7UaR69ttMD6TPtiAY3
   wEd4X+pGgdq4m7BL+Q9W/D02TZu5ncFyzTFui/rRwBOKN47ckGCn1v9pB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="342733212"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="asc'?scan'208";a="342733212"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:14:31 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10548"; a="646913065"
X-IronPort-AV: E=Sophos;i="5.96,210,1665471600"; 
   d="asc'?scan'208";a="646913065"
Received: from subratad-mobl1.amr.corp.intel.com (HELO desk) ([10.209.101.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2022 13:14:30 -0800
Date:   Thu, 1 Dec 2022 13:14:29 -0800
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Stefan Bavendiek <stefan.bavendiek@mailbox.org>
Cc:     kernel-hardening@lists.openwall.com,
        linux-hardening@vger.kernel.org
Subject: Re: Reducing runtime complexity
Message-ID: <20221201211429.venqtlzegdbdc7et@desk>
References: <Y4kJ4Hw0DVfy7S37@mailbox.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vl2okk3xc343pg2o"
Content-Disposition: inline
In-Reply-To: <Y4kJ4Hw0DVfy7S37@mailbox.org>
Precedence: bulk
List-ID: <linux-hardening.vger.kernel.org>
X-Mailing-List: linux-hardening@vger.kernel.org


--vl2okk3xc343pg2o
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Dec 01, 2022 at 09:09:04PM +0100, Stefan Bavendiek wrote:
>Some time ago I wrote a thesis about complexity in the Linux kernel and
>how to reduce it in order to limit the attack surface[1]. While the
>results are unlikely to bring news to the audience here, it did
>indicate some possible ways to avoid exposing optional kernel features
>when they are not needed. The basic idea would be to either build or
>configure parts of the kernel after or during the installation on a
>specific host. Distributions are commonly shipping the kernel as one
>large binary that includes support for nearly every hardware driver and
>optional feature

Is this really true? Most drivers are built as loadable modules and are
only loaded when the hardware is present.

Are you suggesting to configure-out the modules that are always static?
This sounds like an embedded system build.

--vl2okk3xc343pg2o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEhLB5DdoLvdxF3TZu/KkigcHMTKMFAmOJGTUACgkQ/KkigcHM
TKO8Hg/7BtJQa0gxh2s6wp8eQu0bVFa6vPEf4jHnO27WARZRidGnlg9WzOqxF4Pq
BTrdHlRsmrNbW0dl2T2ke2s5bs5YBIb1j/6nAVEiHy58yS89r80AXxIrPuQU6h/u
IeebBtst8mvgj/cOUnguiE191ZmBizyGcgiRDVHTXFOFWBhNBe3dmSUNefgiUpr0
BWKticd6Dm0EeKyOE3xR+gvsdz9kbmw2nE6KXpdwnjcu0VH7tMJx4v/jmzb+EUV4
i/c9p3DmPR6HSBQM3OzMozFt55ttlw+P9R14PHt2oNJWNbgVvdkr8kq6Am4QUn0M
q7QyD6nennNS2Gq5NsOlF6CR3xt1YLGZJjglpOuGGLwF0kNO1JTjlVKdKe3AjkjB
9KS+QVLIcm/KaT8wJaTKZc+AvlHQBRaXgY+X6IwLAPDHkISEqRHjESmDhI4KYSLo
qEhLbVBu+2dnSbn7PAF3dIbqP9Sa3y6ioieRBjBZW6if2IkNHwSxfV1pq6WtkvQ6
3pGbCVu1Ah4LWIqRbfXFkX6VEt9V+A4kiytqNXnBdodZjCeOTNIr6rmbRMH18Z8d
F/4xyh7kNqrbFn68K0mMloR3Oc0eWzdcTtBXjwoNyJ2nuq6i3CEYx+d5QBijCUgf
GDENGYW15VujEs5jfdN+UDdv8xpJFJECs1pdf+WQfKMpyyM+J1I=
=NnWb
-----END PGP SIGNATURE-----

--vl2okk3xc343pg2o--

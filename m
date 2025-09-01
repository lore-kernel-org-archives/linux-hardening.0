Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B03A213E9C;
	Mon,  1 Sep 2025 05:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756704182; cv=none; b=KLno+YzTQ/IW0QzLIC8W+vu/r+e+bKitebzBcQhrqWHJumnMBe+2nkt2xMwqN+IITxiDE1oPxWAs9bpZfXEZWZ/evtU4htZGYaBxwgDPmlnR9MUa/384vFov6PtOzP94lEv9p/29YwvcRBEMh0GpnPLo6LwTFjcO8GwVUvD4ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756704182; c=relaxed/simple;
	bh=YWXOZPlrRtCclbTtH4C2u8OYyvUSZyzeFtK2fwsy+zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mWue4/WIWBbIgd++jPdQCFMsalW5QjkD4QSoqrfJMuLlTUAVRvI7zOI/e3xFGl+CNRJAlTUZGIRObl65Zajw+UTpuI2Dzg+pYnRGTP5VcJxMwq/0IDeKMwgbO06ONhz00YeAV9Zi/laGouZLtjhdMe8NfODkNi2qVTGwg3E/bUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=acbMMyO2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="acbMMyO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3FCC4CEF0;
	Mon,  1 Sep 2025 05:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756704181;
	bh=YWXOZPlrRtCclbTtH4C2u8OYyvUSZyzeFtK2fwsy+zE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=acbMMyO2i05nDsjQ+3V/5j8hI4hruLY7R7f9unrMFYH7KVgHjtK8uAuQQp1ZZp0rG
	 15CmO9rNlNXrrgnhOpi5oz1EQBH4RnHs1IXq01rJqTRVqMwxp0sOvnpdD+IAqYvqvd
	 yiYZTDrUVlgPxpc1NhtQty8Dv1W2khsIO2Ly/mT22N7WAuFwEWlTfKEcfZJ7XJQRoy
	 GKupC8JfAN/a+KeXQog0ZPVVT7sZhE20oynouq3Wk3/2801HkxXltvuWvQTTRxhYnP
	 McIZ2dSo37WVDtXzRnDAMgiNVi+fkHzCU7caYcjfuDmX6l+1kXrobp7v7Ii6PBJ6iB
	 9ZytJymQ1InJA==
Date: Mon, 1 Sep 2025 07:22:58 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc: git@amd.com, michal.simek@amd.com, alexandre.belloni@bootlin.com, 
	Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	kees@kernel.org, gustavoars@kernel.org, jarkko.nikula@linux.intel.com, 
	linux-i3c@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, radhey.shyam.pandey@amd.com, srinivas.goud@amd.com, 
	shubhrajyoti.datta@amd.com, manion05gk@gmail.com
Subject: Re: [PATCH V2 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support
Message-ID: <20250901-sly-cicada-of-management-bf6d73@kuoka>
References: <20250829171327.2590730-1-manikanta.guntupalli@amd.com>
 <20250829171327.2590730-2-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250829171327.2590730-2-manikanta.guntupalli@amd.com>

On Fri, Aug 29, 2025 at 10:43:26PM +0530, Manikanta Guntupalli wrote:
> Add device tree binding documentation for the AMD I3C master controller.
> 
> The controller is represented by the compatible string "xlnx,axi-i3c-1.0".
> The binding specifies required properties including register space, clock,
> resets, interrupts, and provides an example usage.

These two are completely redundant and useless sentences. Binding cannot
specify anything else.

Instead describe the hardware.

Your previous patches for bindings also had completely redundant commit
msg. You need to write WHY you are doing changes or describe the
hardware. Repeating the code is pointless, we can read the code.

Best regards,
Krzysztof


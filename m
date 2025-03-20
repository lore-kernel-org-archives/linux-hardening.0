Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65D81E9B02;
	Thu, 20 Mar 2025 16:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742489729; cv=none; b=hn2UR3iT43vEHa3oCBWeWKS3m2ZB4g7tim7VmmbxBKmzLxqCRXBDFq2hbUY871PfWl7TkV/xy4PNM8OAD4zuYE/ddZkhn/qs9yASKiY6UH7vqdefuGCK6KUdCeJ6olUy6/a7zzekcZbV2I1eTBIwiyybDePoAS0aiBcY1bzyjmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742489729; c=relaxed/simple;
	bh=h830iovzs+H85c6/sS1xXv46lXYYa2W1ibIND2/XF0k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gJV4W8DDF8vPViqR7i7BQtwx1StScD5lVQqZ1ULOXYEY3o3Gkj1drMXqnPWztGq+7f2/4LHZZTblsQkfjH8f+DRoDKG0DtZ9wf/IFckkJDmV8hcIyuAMnD8pHM8Ad5XQA/HrvGCm6n72YLgWoM7h1fJdvjl/iSHblRz+g7O3s8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=MlEEVOai; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="MlEEVOai"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P0Ivq67bbotH4ADjJAlFztdw/IUYFM+eBRURP7U+L1E=; b=MlEEVOaiCDs90bRztnCdRaJ8ow
	OK0zmlKkUw3+EaeajJmdoGHTn6Kq3ENk0vEmbsBu+0tX/1xvNzVUS4OfrbQ/lz1HOWHzvSZG+q1oq
	mDXmR2Jb9BJrw+qDVUbZqkMolVWFZq7SpGAwiRLh7lfbtwfMzApi/DHu41/+eiJ3NXxY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tvJAZ-006V1c-OP; Thu, 20 Mar 2025 17:54:59 +0100
Date: Thu, 20 Mar 2025 17:54:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Willie Thai <wthai@nvidia.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	joel@jms.id.au, andrew@codeconstruct.com.au, kees@kernel.org,
	tony.luck@intel.com, gpiccoli@igalia.com,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, openbmc@lists.ozlabs.org,
	leohu@nvidia.com, tingkaic@nvidia.com, dkodihalli@nvidia.com,
	Mars Yang <maryang@nvidia.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH v3 1/2] ARM: dts: aspeed: Add device tree for Nvidia's
 GB200NVL BMC
Message-ID: <fbf6a89b-80c4-47f3-9dad-2725c040e041@lunn.ch>
References: <20250320164633.101331-1-wthai@nvidia.com>
 <20250320164633.101331-2-wthai@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250320164633.101331-2-wthai@nvidia.com>

>   - Skip mac setting and wait till the delay issue in phy-mode fix from Aspeed SOC vendor side [Andrew]

For this part only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

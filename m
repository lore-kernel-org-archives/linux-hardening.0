Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174D77082A;
	Mon,  8 Sep 2025 14:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757340927; cv=none; b=YQeBOk/KRN7daIrEIWLOSOYa/5o0QVZ0ey6afRJI8PmrYbrsqV+LGRHTi8vuu7SFmSkfrpiC8YILubUJMJN3U7Mqgzxa7LPg43wQeHDpB9yzlxKaQTbSHlZWM72YcZ3GNQ7RtAvqGjGUAaw04Mv8h42RdI1z9dki0h3Z1RS8l00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757340927; c=relaxed/simple;
	bh=7YU1UeI4W5ZZgGKI5I9Pad1avQD9YJzn8mftLPPO940=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=apuwBYso+aAGmNL7AIQqjMRV8yrUkJFZpB4HJAGJgXkA9fe56PDyaaZxNSt6c/NpbSq50O4Tl/hXGv/P3VvuMdPX5P2dCBRmF4msPWURCB8s/eNQAuyw3hiuylYQNiISPByqJQ4cgBfT/Zhou3eX6birBJIO76uVBCcl/RL4FwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBEMa3DL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBEMa3DL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1154C4CEFB;
	Mon,  8 Sep 2025 14:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757340926;
	bh=7YU1UeI4W5ZZgGKI5I9Pad1avQD9YJzn8mftLPPO940=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject:From;
	b=aBEMa3DLnFEhYE5MM8rXin/IPrmqiJAruTHxw1YMdy1L8IKc6Vl9ySelCceSeNJTW
	 TxPPJmu+AFBJXRNOodDcoGEkQchAqxW5lVzKMDUM1m5+gfp6ZfZaKMzBUgTj+ct8tt
	 tcIgRZNynayEmViK8GQTzTNHXelqkwAWOQ9gjDV4UqVSlxzxQGu1tRAmVWenUBCWTZ
	 XS/GCCnU2vPzxhFSDjdZCB8H6JM+Lh+c3JgcHluOyFm5Be9LHw52H1ak2yIpt1Jei9
	 kFKN0+DYjUmbs5iNskMYMVmVvUqk/a0IREvZnQEmDPvVoG/YINVTqRlsqQ/QBMH9E8
	 c6HwqyEHkryAw==
Date: Mon, 08 Sep 2025 09:15:26 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: manion05gk@gmail.com, conor+dt@kernel.org, 
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org, 
 gustavoars@kernel.org, linux-i3c@lists.infradead.org, srinivas.goud@amd.com, 
 alexandre.belloni@bootlin.com, devicetree@vger.kernel.org, kees@kernel.org, 
 michal.simek@amd.com, shubhrajyoti.datta@amd.com, git@amd.com, 
 jarkko.nikula@linux.intel.com, Frank.Li@nxp.com, 
 radhey.shyam.pandey@amd.com, krzk+dt@kernel.org
To: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
In-Reply-To: <20250908112117.205270-2-manikanta.guntupalli@amd.com>
References: <20250908112117.205270-1-manikanta.guntupalli@amd.com>
 <20250908112117.205270-2-manikanta.guntupalli@amd.com>
Message-Id: <175734087989.1809191.3813013625215736173.robh@kernel.org>
Subject: Re: [PATCH V5 1/2] dt-bindings: i3c: Add AMD I3C master controller
 support


On Mon, 08 Sep 2025 16:51:16 +0530, Manikanta Guntupalli wrote:
> Add device tree binding documentation for the AMD I3C master controller.
> 
> Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
> ---
> Changes for V2:
> Updated commit subject and description.
> Moved allOf to after required.
> Removed xlnx,num-targets property.
> 
> Changes for V3:
> Updated commit description.
> Corrected the order of properties and removed resets property.
> Added compatible to required list.
> Added interrupts to example.
> 
> Changes for V4:
> Added h/w documentation details.
> 
> Changes for V5:
> Renamed the xlnx,axi-i3c.yaml file into xlnx,axi-i3c-1.0.yaml.
> ---
>  .../bindings/i3c/xlnx,axi-i3c-1.0.yaml        | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml: $id: Cannot determine base path from $id, relative path/filename doesn't match actual path or filename
 	 $id: http://devicetree.org/schemas/i3c/xlnx,axi-i3c.yaml
 	file: /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/i3c/xlnx,axi-i3c-1.0.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250908112117.205270-2-manikanta.guntupalli@amd.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.


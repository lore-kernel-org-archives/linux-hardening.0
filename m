Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7A0509EFB
	for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 16:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789059401; cv=pass; b=PHAV5oagI1Z/sY28rEx3iTomN3GNPoeZs9twureM9JzZCFvkUH5z5vFZb6mDdGdGD5fiHSo2t1EyxhDeyBC3r6GB4tZDYmvdhU9VzIweULmkcCfWxMfk45M1weSMTKs754GcRzRti/ucqWfHAKqAJOihTPVHsB4tZqOuYi7hi7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789059401; c=relaxed/simple;
	bh=48Yr0M4+GbTCNRGs0VANx8sdxOokODBxtI9C37mhqVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b5YTlcMcXlceNTfjjCLY9Bj+cNHsnjNWkfnv66UowjLg+m2UJpu6bdVjMtDvV+OMAuUo/jiQe9LWaRnkn62y4mSEPy299Nfuk6d7Ii8i9tb9bEIlW+3ySSdgRH20VtED+c50Bgk0GjIdbW2epyQKb4Uo8GSS7E6gyKw6OZ314A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dxY3U167; arc=pass smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dxY3U167"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b76515c0d7so967334e87.0
        for <linux-hardening@vger.kernel.org>; Thu, 10 Sep 2026 09:56:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789059397; cv=none;
        d=google.com; s=arc-20260327;
        b=KFcwJnVktaEuzZtOzN1AmdSvKQAXGWsIxDuSThD4BbuFzhtMYfJhRJThcA2dkTApzR
         IBUi+i2R2UbB3d74M3fzCQIlG4B0pJZ58Pl8jqC+l558s6REmUvkQ9cnvgJEuta2oBSZ
         QAJ5nnE0V1BKHQSkCg5h3eaV2hCwk2yxf5LmtOnnfc/KOXcOIaRkVJnrXgK8rjLLJS7y
         7GkgaEFKwf3D8DuuhbmcwQoS4l+9gEQmxTii4MnsfBGbC8lbDup++NH9c8wJ//NMZppx
         5hTu/P4d8/u9yFxSN+g4XZTw83ZOW6o1GmjcoapIcXldruyF2QAl/ZaPb4xwbpaBZIEz
         owFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=48Yr0M4+GbTCNRGs0VANx8sdxOokODBxtI9C37mhqVU=;
        fh=TdXUsAFOpNP7gQSA4VHb2kXKwGf+MSvN96eM2Gz3HHA=;
        b=pFJ2fMT5WpFgsH1Tzf7T/wclEsnGaLS/+3U2OI+yDifs1Vnqcb/d8CTVQOLaD5JT/q
         dY1dse76Hhh48fT8H3M2HO6Wy9pEgD+0EGcuyL+U3NEHrM1nBCrG+6dW7SkC3W08p+xC
         mrzmbl8AGVHLbQZwpq8EyOPKBIvR19416saoySgTjyfrBO4yR7Nfjg/SZvbXGLXO6Wim
         Ddfzc42wYlluG1s+1m4z/D3J9fJzJ3OCbpg1DCul2oTn33R8FcdizSBBUXdUOjY0iXxe
         9FSvilPcjeaWC13zJjuJXfC9zdXG47g8m2WxpvqWhUOqS1q5HT6BU+61izbuQcdoWPJR
         tBwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789059397; x=1789664197; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=48Yr0M4+GbTCNRGs0VANx8sdxOokODBxtI9C37mhqVU=;
        b=dxY3U167tw3Blu1zgBWr4m3yTDj1d9H2F5/4ohkb8wBPvrQpgpAbv3rClChx7vM2Mc
         IdFbrf/0iEw2qgxwX8h5mRZssd3hJ/cuG20fVRJ7L1CmBjkhl4YYfIuEJo7z7eCGipHO
         iPUFTrPRtE5lskd0wg8UUSCzZinHgPl5r9eOUCNDNifPykNivRGFet4vXBOyHRuDsmYK
         +7H+Vr5UYoPD8JGFg/Kr6C2qgIpsOqXR1/1agOe12a4ELBgePEB9aT1lazw9Y+OQqO1/
         GmQHcSOaHZ5VdJ75d05TDBx3BTttil1MALWHpQdKNh6rCUxAAWB+OZ6OJOUNeFFaqqxA
         o6KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789059397; x=1789664197;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=48Yr0M4+GbTCNRGs0VANx8sdxOokODBxtI9C37mhqVU=;
        b=Tjf0PxrDcchhnNWpaeIuTWAKlXOxCS5OCjAOA8feIjOrt4tCXRDjcYRyK6E63e1lLg
         GoYTOs0iVDTOlaXqLCWE2fRhx7vAEwndHxUPILw8NnmGPnP+KGkuhE/l3x17F+aI5Oiw
         FHinsXO/4L+PDVrpjmTIs94tABtG9TxTp1+6x8T5gLWvIim2dFXsZIyI1kKrM95IKHNh
         ZazQ5uOcWLO5M8Hps1UCdmlQxaU6qRZsp5EWrPe+cwXOoXAEqnDbaP6+GcUxMRBWgE9i
         iyzPWXjqDAR7BOgHf7+zv4v6DOo/HyrAo94Olb3VAiJqre3W0XjnkxihuC4p8JRC54Da
         B5vw==
X-Forwarded-Encrypted: i=1; AKwUvByozgxTElqKFzxli6gP2LqFh7zVgS3AFPVO/Ub0cEoCgp5K3HXqsLhD74NK9rXBei8vs7BTBrXZ3A7b5yLdzm4=@vger.kernel.org
X-Gm-Message-State: AFuF++k0zijBRQ1wJI5/2lDfnMuNsbBTTKLEZ6S/K3tZWNN0qdDfs3f2
	34HVN3Y6qRd5/+lED9I3ZCMnBnQPMuhztTyKfEnpJHr9g1ViC/DofO2C7hbV5RBwcR78Sloi53v
	Nw1VJxjxNOxY2Z4CpxcsM/c2c+zJoQX8=
X-Gm-Gg: AYBFou21Ngt/mwM46R0iD5kHnhPdSc5jO0o60BszarKmgXdv7JE8IjV2ivTlGp15Pte
	4ctNQmlXJv0hf+dj78Kg2wvv0tN6OKuLPckopYBknJGjfFXsLWCBpZpGj11CuXrlCc3E8DHbjBN
	GfYRI69+nSnlHTN8CTMJU+w+IUF3GNDE9XKbiMcs6OE3ZTQh6GHvQ4ZQg1UVc5gwlX5Uw/dCNDI
	+rJCi6FgT3066qDqA45C5eRSg4vNP45Icb3ccUU2g0qv4VW4DEqUWZVVkaM6iGoLTEqcUtiOXWW
	57JwwlrPynQ1rti8cbmeIMmB8nwBVEhtwJ55JDhxg4AZhGsQqJutSmmCRWB+aMFdIT62CjP2Tyw
	sV9KlbpJ8V8mpL+6/54b/63LqGdumi4/4EowQ3Y1v+MJYqQwK
X-Received: by 2002:a05:6512:a92:b0:5b6:1aee:95f7 with SMTP id
 2adb3069b0e04-5b89a37bf4cmr1102365e87.43.1789059396760; Thu, 10 Sep 2026
 09:56:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1787502624.git.ahmadexp@gmail.com> <f04b85bbf71a09f372b1f248dbd2b1286a0ba903.1787502624.git.ahmadexp@gmail.com>
 <20260910123528.GA1051768@google.com>
In-Reply-To: <20260910123528.GA1051768@google.com>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Thu, 10 Sep 2026 09:56:25 -0700
X-Gm-Features: AcwNN1WQJyaMmPXUVD3vdCAdJhASvoUrxNU6PY-XwXiL3uKfg05bB7LcJcmHdc4
Message-ID: <CAOQiBWM_506kwk5Pg5HwBhHObtpWN2C0e+OducwfF6ER7ouh0g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] leds: is32fl3207: Add controller driver
To: Lee Jones <lee@kernel.org>
Cc: Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Nam Tran <trannamatk@gmail.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, Jakub Kicinski <kuba@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Lee,

Thanks for the detailed review. I will address the cleanup points in v8:
remove the redundant led_cdev pointer, populate brightness directly in
the class device, use chip consistently, use loop-local indices, and
fix the wrapping, alignment, braces, and spacing. I will also name the
current-scaling factors and the two PWM bytes per channel, and explain
the output-disable fallback when the initial PWM latch fails.

I will drop the unsupported-property list for multicolor components.
The binding already disallows those properties on component nodes; I
will clarify that brightness, default state, and shutdown retention
belong to the group.

> Is it even architecturally possible to set brightness on a shutdown or
> disabled LED? That sounds like a bigger problem.

The guard is intended for system shutdown, rather than normal LED
unregistration. In the current LED tree, led_classdev_unregister() stops
software blinking and flushes set_brightness_work. The system shutdown
path does not call that function, and i2c_device_shutdown() calls the
driver's shutdown callback without draining LED brightness work.

A previously queued brightness callback can therefore run after our
shutdown callback. Both paths take the same controller mutex; setting
shutting_down under that lock prevents a later callback from writing
registers or changing the final retained state. This also matters when
some LEDs retain their state and the controller must remain enabled.

I will retain the guard and add a comment explaining that distinction.
This is based on inspection of the shutdown and LED-core paths, not a
hardware reproduction of the race.

Regards,
Ahmad

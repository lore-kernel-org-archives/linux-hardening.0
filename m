Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD053B7746
	for <linux-hardening@vger.kernel.org>; Fri,  4 Sep 2026 15:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788536869; cv=pass; b=E9/Dc3wAgIVjLIWXG9y2Xt1Gej5QsiZXlKavU+LYcBMEJpLrg/4YE0ERWPvLLYjmFEJ1RW+ktsA//v6wm1F7JrComioz5c/h+OegJ+FlvN+kuCS+0e9nAShwqyfxV8+t98tlQUdkUfska9C6VfhQCoxF3isOUijPmflQMwjI6T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788536869; c=relaxed/simple;
	bh=p+zh2bzF68CPu34Qj0MIgenIKNyb+Zlsh4hE21X56RA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C06upFY8m2nBSI0QwL+BpJAuoSPeRR9/BeevPlnKoBAfcW9cKfp0Db5v1FD1YFpzQYauRF0W+tDaM9bkaVuGs01NtIF71jzcMS7mg5ae3m8layGTIOirZd9Jr6gM/rK52hwNmckuPAB2Bp1oGpq8pcwiXAm2a20kfSSlm5IDh7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=a/7xyiyC; arc=pass smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="a/7xyiyC"
Received: by mail-qk2-f12.google.com with SMTP id d75a77b69052e-53012819c04so247101cf.0
        for <linux-hardening@vger.kernel.org>; Fri, 04 Sep 2026 08:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788536867; cv=none;
        d=google.com; s=arc-20260327;
        b=hKGPwX9S7yUb5tCrEW5POWOBJbFnNPPjirWCcffisFkIE9LTeBoqSy2ZUiuY3bs4X1
         qKTLerr1MndN3w8UKS1huXMpy3LxN9w6K4/4JUYXS7ghoEA4t48suwHPOLv7NFu3SOxj
         fYGGmlTPhkwbWyyNHHy8Hztm4ONjwNpdM0gNhvfFpLjm1n8Gu/JwS6j41uSbQejmbpwh
         +0n/Jpg2lMy8mfCedLNgiJbFS4BW5st075C5qEV1409hREW4jjWDU/WjS8y2QW9Wd4q0
         DBmKfp4hGCvcU1grlkL9L+x79vfCrFEBxOsdD2hQmO4XLpmwS2q8G0HTI88oluKG6uw8
         XlZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IPT68QRfKVLmVSBV+Z0zwKsA2eXY2NxVNEpWEIXhKXk=;
        fh=kTeCaEA735hllN8TzX9PYK+bvBuAsCnl1aS1YG8P4U8=;
        b=Pz5Vb6hHZClAVdFFidyZ2CDmtCoGGvEvb+rFHVZxB6QSyKc63rVwtmwH4vKRZyycFN
         ssY1w7Fyn+vre6eRR7SPtisuolP0/TPYycmKs1qICu2BdkbcXcLGdJAVXnlJm75MpRc4
         OBgZl6GXYwkPok9vjds3zWCOBI60XoZqpuDZHYkGgXB9ZG9dgcKTp6LXWHfSP2rooMuq
         sjwj/WbWjq8dSy2PMofanUbAH0IfgwVBSMs7EQyqjND6zi2PG6yudBtX0W9oMPlV7oul
         qMqBYKIlR02fZEf9xr161jXkCm8gA7N3t8IfbxUZzHxxccSvbStdyX0wKTgQ/ZtAiNFc
         mLNw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788536867; x=1789141667; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IPT68QRfKVLmVSBV+Z0zwKsA2eXY2NxVNEpWEIXhKXk=;
        b=a/7xyiyCdypPbcdV6VYvL0cHbeGVsGbUJuuQtzWoIO4O+OnZMFbZlWZwSKWvH1omHR
         7tfl9inDLG/xzEEay1Md0u5mWY4t4qzMqq4OoWnhlmAz2591UiYbwZDITdjhz3R1Frzp
         p7fWDrIxG2Hmw+61gaOVIQexpNKDgV+BsUSLlQCXtFITsulCnpMCfY9AXQEZFDqqILaW
         hmx/XGi8hCUXVPoV52uoRj+DKn541sf2MZ7FC7kQanHFUW2K5IXSmOMZs87ZwhoImMAi
         QcO0oODNlxwfXim5SwhkGrZvwBrHf5i1wzqkJdnYFGy3bIi/QXjEkZzj1ibdA99cFM8Z
         GmNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788536867; x=1789141667;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IPT68QRfKVLmVSBV+Z0zwKsA2eXY2NxVNEpWEIXhKXk=;
        b=euDuz3E261YtEsUBO5CoqwjiOFvo6zIqBq/Gt0K5953//ZhdrJml2E8BOtZCXHU2pq
         8KtZRWnUlhV77Xs3cmWlBOEUz6y+cso2TZ2FuvEL77XLPbEPvnXZmuKxDOTlkGQNCeUk
         k+E+eW7Bbf7O3XOJUiLAXtO8FUaZ7tRdkR5x2sT32BywJXF3qbn6JnM3cDfpkMW2zpGX
         Mb2lriQN8BY08LuOgkkThGKaQLubvUh0LBP2owGpVVqA4e09z7UG6CCsrTf8qCyq7WpJ
         j5xnfsEiKXiCtlj7HdUE4tmp8GtZFJyTLRhkZjOYPcZOovvmh5MJ8x3fX5+7sNk+ZldC
         +gvw==
X-Forwarded-Encrypted: i=1; AKwUvBy/EK2/X16ZOYSrqKsfNsDRS2BDNBDrzhbAJUPVi8x1PLeBRQ70COe2iSxaHTSi6RGJS/N1dIVk+aUtNTmfH88=@vger.kernel.org
X-Gm-Message-State: AFuF++mUuIL6E01rvwrpmCtSWStBF9nhUYa+Gs07QsxRpjJjYPKkKfAM
	VWH+9kzk60rweyADjD3qAsIqs9g1Piw1dFJ0b5LuL+73SvThWLFJkreKeTIvnqE3cNdJz5yB2Uh
	2RQ5/yRDZ0oRpAsBTvh/D4CO6K825vfQMoIODJ8d2
X-Gm-Gg: AYBFou1c0HdxWR5QazXYBHZtrAEDnx1xlWEXOB9mYFxe/RdTy5Uqqez6P063BCKsvnx
	Kevif3L6F3xpLKAoQOZk7sl9JUGVEEODndQllJbGb/qGrOaC+FdJ44qd6OO7jiZnnVaSCpdpBaM
	bjdYMp5YfZpEvCXXXbGKViE5H2tYZ6no61RQHjEmCpZmXo4L/x9m1rjyEbCHBqf8cxf50AXt80b
	9WwW8q//JbKJ0PJ220/szkc9WWGMp48gGxG9p5y4bK4zL98nKomKKpg/djj4ANIhsyhJXxgM44f
	Bv42rE7qWanq9+p3KY/iIQ/E5Ete1BrsGCPi5ZuePyQ2BOUwiG1LDj5dqji49mgn1dUks5PAh/g
	=
X-Received: by 2002:ac8:5885:0:b0:517:5e32:2d14 with SMTP id
 d75a77b69052e-530559ca407mr14443271cf.10.1788536861883; Fri, 04 Sep 2026
 08:47:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904141659.224248-2-blum@kernel.org>
In-Reply-To: <20260904141659.224248-2-blum@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Fri, 4 Sep 2026 08:47:30 -0700
X-Gm-Features: AcwNN1VSiKV_AEbMzp_nMXjvTTquw6BllzUYWamLFbu4C-WtIUHXX0dMd892YtI
Message-ID: <CAP-5=fWj0YAUimSwGLrZpikH4dHkWSsupyE+esbNg6rM-m1sUg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/intel: Annotate x86_pmu::hybrid_pmu with __counted_by_ptr
To: Thorsten Blum <blum@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 7:17=E2=80=AFAM Thorsten Blum <blum@kernel.org> wrot=
e:
>
> Add __counted_by_ptr() to x86_pmu::hybrid_pmu to improve access bounds
> checking via CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
>
> Signed-off-by: Thorsten Blum <blum@kernel.org>
> ---
>  arch/x86/events/perf_event.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
> index 71ed5b2acea2..b66691a4fc31 100644
> --- a/arch/x86/events/perf_event.h
> +++ b/arch/x86/events/perf_event.h
> @@ -1050,7 +1050,7 @@ struct x86_pmu {
>          * unique capabilities.
>          */
>         int                             num_hybrid_pmus;
> -       struct x86_hybrid_pmu           *hybrid_pmu;
> +       struct x86_hybrid_pmu           *hybrid_pmu __counted_by_ptr(num_=
hybrid_pmus);

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

>         enum intel_cpu_type (*get_hybrid_cpu_type)      (void);
>  };
>

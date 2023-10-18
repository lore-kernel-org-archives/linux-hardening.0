Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2820307
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OBX3H2C7"
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E90111C
	for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 12:07:47 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-41cb7720579so52451cf.1
        for <linux-hardening@vger.kernel.org>; Wed, 18 Oct 2023 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697656066; x=1698260866; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jLh+LVsADEpQn0tXrIhHZOOTufYjaEXj860xp7E8aI=;
        b=OBX3H2C7k1EqfyqW6yvKPa2SMVSMKpojBHDSs9X6IFDbHhwz7rEZ+vLnjVJ/u8WUFd
         USUIZ0xyxBU3qjJ6pmlJyd9GVnOJToHmFvaMQlK/RWfn04ck6DIFiIxjvjhmdg25H41w
         PpY+uW4qizmSEiX6HVtaL5XEId/RlnSf4VLw+PS1qHJ3jYmz7sK8UaZNQyGyJGENNGBj
         5ca6Rz+UxDfZGbB64SG1Kd8kZpiPHL9hYyXhScTe6ncOdDxAkVat0E8SPmlXG9DXbweT
         uoSedXxbrvJhfTOqO/5tu3veC0Vj3F/G82CN3wd0C49rPMbwBcsVamx6jUWaFo5CokOh
         hvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697656066; x=1698260866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jLh+LVsADEpQn0tXrIhHZOOTufYjaEXj860xp7E8aI=;
        b=MHpFS8lBrXLVtsvPGZm2WVtKnNA0MHS6PDCgXxGEkpVhWpEFcDrv5zWbP4mk37zh9d
         3aeo8TDkSXqcjiaezxqKxgU5yg6E+dWnfAuaPeEC2MZ2io8HxSEEndoiPN9OuOIUdf1z
         1a4hgYBXjEOjKXlf70k6ZCX1rurYZ684VTJebOt4YeBNf3PVfyGcSg4cWue1s3Jjx2AW
         t5YIhjjlhMgW8/gS+ZNZKuLnc7I620gYXAqc24utVDvIMdFPI3VWo+Vd4R18QzyGokta
         ImAp1O+akt0jl0K2DYaNSi3VJPkNTZye+R9on3RzjlpUCZZS3u/EWjRVVMorbgTMn57D
         crXg==
X-Gm-Message-State: AOJu0YzUPaBd4jONxlYTJxM0C/iKum6YtDgxhh2MKD1PjAaBaHYvR/Jl
	kTOGJHRzHLisYUJSYh5I9BSq/QYUZzIQWqckrv20/g==
X-Google-Smtp-Source: AGHT+IEfpqH+NCZtb7mB+SU291n5YTFgfJ3T5+Hg/iP5B84SoIbdRXNJIdwzGfDI551ZVJup3pkbx5z6Q9EAvjVvxG8=
X-Received: by 2002:ac8:4d5d:0:b0:41c:b700:fb84 with SMTP id
 x29-20020ac84d5d000000b0041cb700fb84mr57193qtv.2.1697656066547; Wed, 18 Oct
 2023 12:07:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hardening@vger.kernel.org
List-Id: <linux-hardening.vger.kernel.org>
List-Subscribe: <mailto:linux-hardening+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hardening+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231017090815.1067790-1-jeffxu@chromium.org> <20231017090815.1067790-6-jeffxu@chromium.org>
 <CAHk-=wgwdHzOY_mT3y9gDHSMXZ8Xb5OYrK40-u9uRXLv25fNPA@mail.gmail.com>
 <CALmYWFux2m=9189Gs0o8-xhPNW4dnFvtqj7ptcT5QvzxVgfvYQ@mail.gmail.com>
 <CALmYWFvgM7DOihdUpUC5SREhUMn9t53HYCX+YioeHHhLSD1KHw@mail.gmail.com> <CAHk-=wixGw88-OzcFbCLEuAzSe53oUUozdM-E_RJwvejgY6ySA@mail.gmail.com>
In-Reply-To: <CAHk-=wixGw88-OzcFbCLEuAzSe53oUUozdM-E_RJwvejgY6ySA@mail.gmail.com>
From: Jeff Xu <jeffxu@google.com>
Date: Wed, 18 Oct 2023 12:07:10 -0700
Message-ID: <CALmYWFssV_nqOBKR0=8ka8vOP2v__8Nx_dL_kLs53W_RbYXViQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 5/8] mseal: Check seal flag for munmap(2)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: jeffxu@chromium.org, akpm@linux-foundation.org, keescook@chromium.org, 
	jannh@google.com, sroettger@google.com, willy@infradead.org, 
	gregkh@linuxfoundation.org, jorgelo@chromium.org, groeck@chromium.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-mm@kvack.org, surenb@google.com, alex.sierra@amd.com, 
	apopple@nvidia.com, aneesh.kumar@linux.ibm.com, axelrasmussen@google.com, 
	ben@decadent.org.uk, catalin.marinas@arm.com, david@redhat.com, 
	dwmw@amazon.co.uk, ying.huang@intel.com, hughd@google.com, joey.gouly@arm.com, 
	corbet@lwn.net, wangkefeng.wang@huawei.com, Liam.Howlett@oracle.com, 
	lstoakes@gmail.com, mawupeng1@huawei.com, linmiaohe@huawei.com, 
	namit@vmware.com, peterx@redhat.com, peterz@infradead.org, 
	ryan.roberts@arm.com, shr@devkernel.io, vbabka@suse.cz, 
	xiujianfeng@huawei.com, yu.ma@intel.com, zhangpeng362@huawei.com, 
	dave.hansen@intel.com, luto@kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 18, 2023 at 11:27=E2=80=AFAM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 18 Oct 2023 at 10:14, Jeff Xu <jeffxu@google.com> wrote:
> This is simply not up for discussion. Any flag for "ignore sealing" is wr=
ong.
>
> We do have one special "unmap" case, namely "unmap_vmas()' called at
> last mmput() -> __mmput() -> exit_mmap().
>
> And yes, that is called at munmap() time too, but that's after the
> point of no return after we've already removed the vma's from the VM
> lists. So it's long after any error cases have been checked.
>
Ah. I see.
I didn't know there was no legit case, which is what I worried about before=
.
this flag can be removed.
